//
//  ViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateUpdateResponder, GameChosenResponder, gameInitializeResponder, GridViewRegistrant{

    var underlyingView: SplashView?
    var _gameController: GameViewController = GameViewController()
    var _listController: GamesListViewController? = nil
    var _transitionController: TransitionController = TransitionController()
    var _serverManager: ServerGameManager = ServerGameManager()
    var _gameNameController: gameNameController = gameNameController()
    var _gameModel: Game = Game()
    var _myGamesController: MyGamesListViewController = MyGamesListViewController()
    
    
    //NETWORK IMPLEMENTATION VARIABLES
    var _playerController: PlayerViewController = PlayerViewController()
    var _currentPlayerGUID: String = ""
    var _currentGameGUID: String = ""
    
    var playerShipGrid: ShipGrid = ShipGrid()
    var opponentShipGrid: ShipGrid = ShipGrid()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
  
    override func loadView()
    {
        _serverManager.refreshGamesList()
        underlyingView = SplashView()
        underlyingView?.delegate = self
        _gameNameController._underlyingView.delegate = self //this controller will listen to create game signals
        _listController = GamesListViewController()
        _listController!.gameJoinDel = self
        _listController!.gameStartDel = self

        _listController!.appDel = self
        _myGamesController.gameStartDel = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
 
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        title = "Start"
        
        _playerController.getGridsDelegate = self
        _playerController.delegate = self
        
        _transitionController.delegate = self
       // _serverManager.createGame("Digimon", playerName: "Philipe")
    }
    
    func AppStateChanged(reason: String) {
        
        switch(reason)
        {
        case "new":
            _gameModel = Game()
            self.navigationController?.pushViewController(_gameNameController, animated: true)

        case "list":
            self.navigationController?.pushViewController(_listController!, animated: true)
        
        case "myGames":
            _myGamesController.serverGameManager.loadGameIDsFromFile()
            self.navigationController?.pushViewController(_myGamesController, animated: true)
        case "stall":
            stallUntilMyTurn()
   
            
        default:
            return
            
        }
    }
    //called whenever we are to create a new game
    func signalCreateGame(gameName: String, playerName: String)
    {
        _serverManager.createGame(gameName, playerName: playerName)
        var summaryAlert = UIAlertView(title: "Created", message: "Game \(gameName) has been created. Status is waiting. Return to lobby to play", delegate: nil, cancelButtonTitle: "Close", otherButtonTitles: "OK")
        
    }
   
    //called whenever we are to join an existing game
   func signalJoinGame(playerName: String, id: String)
   {
        _myGamesController.serverGameManager.joinGame(playerName, gameID: id)
        self.navigationController?.popToRootViewControllerAnimated(true)
        self.navigationController?.pushViewController(_myGamesController, animated: true)
   }

    func initGame(gameGUID: String, playerGUID: String)
    {
        var res: NSMutableDictionary = _myGamesController.serverGameManager.getBoardsForPlayersInGame(gameGUID, PlayerID: playerGUID)
        
        var playerGrid: ShipGrid = res["playerBoard"] as ShipGrid
        var opponentGrid: ShipGrid = res["opponentBoard"] as ShipGrid
        playerShipGrid = playerGrid
        opponentShipGrid = opponentGrid
        
        //save these so we can access this data to refer to the current game
        _currentGameGUID = gameGUID
        _currentPlayerGUID = playerGUID
        
        self.navigationController?.popToRootViewControllerAnimated(false)
        self.navigationController?.pushViewController(_playerController, animated: true)
     
    }
    
    func getRowAndColumn (row: Character, column: Int)
    {
     //make a guess and wait until its my turn again
        var hit: turnResponse = turnResponse(hit: false, valid: false)
        
    hit =  _myGamesController.serverGameManager.makeAGuess(_currentGameGUID, PlayerGUID: _currentPlayerGUID, col: column, row: getIntValue(row))
        
        var title: String = "Missile Launched"
        var msg: String = ""
        if(hit._hit && hit._valid)
        {
            msg = "HIT! at \(row):\(column)"
        }
        else if(hit._valid && !hit._hit)
        {
            msg = "MISS! at \(row):\(column)"
        }
        else
        {
            msg = "Not Your Turn"
            title = "oops"
        }
        var wasHit = UIAlertView(title: title, message: msg, delegate: nil, cancelButtonTitle: "Close", otherButtonTitles: "OK")
        wasHit.show()
    
        _playerController.title = "WAITING"
    
    }
    
    func stallUntilMyTurn()
    {
        var stall: Bool = true
        
        while(stall)
        {
            if(_myGamesController.serverGameManager.getIsMyTurn(_currentGameGUID, PlayerGUID: _currentPlayerGUID))
            {
                break
            }
             _playerController.title = "Your Turn"
        }
        
   
    }
    

    func getIntValue(c: Character) ->Int
    {
        let s = String(c).lowercaseString.unicodeScalars
        let uniVal = Int(s[s.startIndex].value)
        let aInUnicode: Int = 97
        let value: Int = uniVal - aInUnicode
        
        if(value < 0 || value > 9)
        {
            return -1
        }
        return value
        
    }
    
    

}

class turnResponse
{
    var _hit: Bool
    var _valid: Bool
    init(hit: Bool, valid: Bool)
    {
        _hit = hit
        _valid = valid
    }
    
}





