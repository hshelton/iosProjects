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
        _gamePlayController._player1ViewController.saveDelegate = self
        _gamePlayController._player2ViewController.saveDelegate = self
        _listController!.appDel = self
        _myGamesController.gameStartDel = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
 
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        title = "Start"
        
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
            self.navigationController?.pushViewController(_myGamesController, animated: true)
        
            
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
        _serverManager.joinGame(playerName, gameID: id)
   }

    func initGame(gameGUID: String)
    {
        
    }


}

