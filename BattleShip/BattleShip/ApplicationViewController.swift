//
//  ViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateUpdateResponder {

    var underlyingView: SplashView?
    var _gameController: GameViewController = GameViewController()
    var _listController: GamesListViewController = GamesListViewController()
    var _placementController: ShipPlacementController = ShipPlacementController()
    var _gamePlayController: GamePlayController = GamePlayController()
    
    var _gameModel: Game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _placementController.delegate = self
    }
  
    override func loadView()
    {
        underlyingView = SplashView()
        underlyingView?.delegate = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = "Start"
    }
    
    func AppStateChanged(reason: String) {
        
        switch(reason)
        {
        case "new":
            _gameModel = Game()
            _placementController = ShipPlacementController()
            _placementController.delegate = self
            self.navigationController?.pushViewController(_placementController, animated: true)
        
        case "list":
            self.navigationController?.pushViewController(_listController, animated: true)
        
        case "placed":
            if(_gameModel.P1Turn)
            {
                _gameModel.P1Turn = false
        
                self.navigationController?.popToRootViewControllerAnimated(true)
                underlyingView?.renameButton("P2 Place Ships")
                _gameModel.Player1Grid = _placementController._shipGrid
            }
            else
            {
                _gameModel.Player2Grid = _placementController._shipGrid

                self.navigationController?.popToRootViewControllerAnimated(false)
                _gamePlayController._gameModel = _gameModel
                self.navigationController?.pushViewController(_gamePlayController, animated: true)
                underlyingView?.renameButton("New Game")
            }
         case "newP2":
            _placementController = ShipPlacementController()
            _placementController.delegate = self
            self.navigationController?.pushViewController(_placementController, animated: true)
            
        default:
            return
            
        }
    }

    

}

