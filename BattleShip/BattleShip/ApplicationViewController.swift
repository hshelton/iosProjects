//
//  ViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateUpdateResponder, GameChosenResponder, gameInitializeResponder{

    var underlyingView: SplashView?
    var _gameController: GameViewController = GameViewController()
    var _listController: GamesListViewController? = nil
    var _gamePlayController: GamePlayController = GamePlayController()
    var _transitionController: TransitionController = TransitionController()
    var _serverManager: ServerGameManager = ServerGameManager()
    var _gameNameController: gameNameController = gameNameController()
    var _gameModel: Game = Game()
    var _myGamesController: MyGamesListViewController = MyGamesListViewController()
    
    
    //this is the new game controller
    var _playerController: PlayerViewController = PlayerViewController()

    
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
        _transitionController.delegate = self

        _listController!.appDel = self
        _myGamesController.gameStartDel = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
 
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        title = "Start"
        
        _playerController.getGridsDelegate = self
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
        
        case "requestGrids":
            _playerController._yourGrid = playerShipGrid._grid
            _playerController._opponentGrid = opponentShipGrid._grid
            _playerController.supplyShipGrid()
            
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
        
        self.navigationController?.popToRootViewControllerAnimated(false)
        self.navigationController?.pushViewController(_playerController, animated: true)
     
    }

}

protocol serverManagerInterface: class
{
    
    
    
}

