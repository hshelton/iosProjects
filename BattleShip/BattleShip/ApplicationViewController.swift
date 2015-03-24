//
//  ViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateUpdateResponder, gameLoader {

    var underlyingView: SplashView?
    var _gameController: GameViewController = GameViewController()
    var _listController: GamesListViewController = GamesListViewController()
    var _placementController: ShipPlacementController = ShipPlacementController()
    var _gamePlayController: GamePlayController = GamePlayController()
    var _transitionController: TransitionController = TransitionController()
    var _gameSavesArray: NSMutableArray = []
    var _lastSavedGameNumber: Int = 0
    
    var _gameModel: Game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _placementController.delegate = self
        loadFromFile()
        _listController.numberofGameSaves = _lastSavedGameNumber
    }
  
    override func loadView()
    {
        underlyingView = SplashView()
        underlyingView?.delegate = self
        _listController.delegate = self
        _transitionController.delegate = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = "Start"
        
      

        var saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", style:UIBarButtonItemStyle.Plain, target: self, action: "writeToFile")
     
        self.navigationItem.rightBarButtonItem = saveButton
        
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
                _gamePlayController.delegate = self
                
                self.navigationController?.pushViewController(_transitionController, animated: true)
                underlyingView?.renameButton("New Game")
            }
         case "newP2":
            _placementController = ShipPlacementController()
            _placementController.delegate = self
            self.navigationController?.pushViewController(_placementController, animated: true)
        case "ready":
            self.navigationController?.pushViewController(_gamePlayController, animated: true)
        case "gameOver1":
           self.navigationController?.popToRootViewControllerAnimated(true)
           var alertView = UIAlertView();
           alertView.addButtonWithTitle("Game Over");
           alertView.title = "Game Over";
           alertView.message = "Player 1 Wins";
           alertView.show();
           reinit()
            
        case "gameOver2":
            self.navigationController?.popToRootViewControllerAnimated(true)
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK");
            alertView.title = "Game Over";
            alertView.message = "Player 2 Wins";
            alertView.show();
            reinit()
        default:
            return
            
        }
    }
    
    //game saves are being loaded in as NSDictionary objects
    func getGame(number: Int)
    {
        var what = _gameSavesArray[number] as NSDictionary
    }
    
    
    func reinit()
    {
        _gameController = GameViewController()
         _listController = GamesListViewController()
        _placementController = ShipPlacementController()
      _gamePlayController = GamePlayController()
        
        _gameModel = Game()
        
          _placementController.delegate = self
        underlyingView = SplashView()
        underlyingView?.delegate = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = "Start"
        
    }
    
    
    func writeToFile()
    {
        
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("gameSaves10.txt")
        var arr: NSMutableArray = []
        
        //add all the game saves to the master array
        for entry in _gameSavesArray
        {
            arr.addObject(entry)
        }
        //add the current game to the master array
        var ongoing: Bool = _gameModel.Player2Fleet.isDestroyed || _gameModel.Player1Fleet.isDestroyed
        let gameSave: NSDictionary = ["p1Grid": _gameModel.Player1Grid._grid, "p2Grid": _gameModel.Player2Grid._grid, "p1turn": _gameModel.P1Turn, "ongoing":ongoing]
        arr.addObject(gameSave)
        
        //write to disk
        arr.writeToFile(filePath!, atomically: true)
        
        loadFromFile()
    }
    
    func loadFromFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("gameSaves10.txt")
        //load in the file to memory
        let fileText = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        _gameSavesArray = []
        var readArray: NSArray? = NSArray(contentsOfFile: filePath!)
        if let activeArray = readArray
        {
         
            for(var i=0; i < activeArray.count; i++)
            {
                var readDict: NSDictionary = activeArray[i] as NSDictionary
                
                //add all the read in game saves to the master array
               _gameSavesArray.addObject(readDict)
            }
            
            setGlobalSaveNumber(activeArray.count)
        }
      
    }
    
    func setGlobalSaveNumber(count: Int)
    {
        _lastSavedGameNumber = count
        _listController.numberofGameSaves = _lastSavedGameNumber
    }
    


}

