//
//  ViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateUpdateResponder, GameChosenResponder{

    var underlyingView: SplashView?
    var _gameController: GameViewController = GameViewController()
    var _listController: GamesListViewController = GamesListViewController()
    var _gamePlayController: GamePlayController = GamePlayController()
    var _transitionController: TransitionController = TransitionController()
    var _serverManager: ServerGameManager = ServerGameManager()
    var _gameNameController: gameNameController = gameNameController()
    var _gameModel: Game = Game()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
  
    override func loadView()
    {
        _serverManager.refreshGamesList()
        underlyingView = SplashView()
        underlyingView?.delegate = self
        _gameNameController._underlyingView.delegate = self
        _transitionController.delegate = self
        _gamePlayController._player1ViewController.saveDelegate = self
        _gamePlayController._player2ViewController.saveDelegate = self
        _listController.appDel = self
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
            self.navigationController?.pushViewController(_listController, animated: true)
        


            
        default:
            return
            
        }
    }
    //called whenever we are to create a new game
    func signalCreateGame(gameName: String, playerName: String)
    {
        _serverManager.createGame(gameName, playerName: playerName)
    }
    
    


}

