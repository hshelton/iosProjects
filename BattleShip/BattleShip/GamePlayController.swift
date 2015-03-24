//
//  GamePlayControllerViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/22/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class GamePlayController: UIViewController, GridViewRegistrant, AppStateUpdateResponder {

    
    var _gameModel: Game = Game()
    var _player1ViewController: PlayerViewController = PlayerViewController()
    var _player2ViewController: PlayerViewController = PlayerViewController()
    var _transitionViewController: TransitionController = TransitionController()
    var explodeSound: SystemSoundID = 0
    var missSound: SystemSoundID = 0
  
    weak var delegate: AppStateUpdateResponder? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        _player1ViewController._opponentGrid = _gameModel.Player2Grid._grid
        _player1ViewController._yourGrid = _gameModel.Player1Grid._grid
        _player2ViewController._opponentGrid = _gameModel.Player1Grid._grid
        _player2ViewController._yourGrid = _gameModel.Player2Grid._grid
        _player1ViewController.delegate = self
        _player2ViewController.delegate = self
        _transitionViewController.delegate = self
        _gameModel.P1Turn = true
        
        // Load sounds
        let soundURL = NSBundle.mainBundle().URLForResource("explode", withExtension: "mp3")
        AudioServicesCreateSystemSoundID(soundURL, &explodeSound)
        
        let soundURL2 = NSBundle.mainBundle().URLForResource("miss", withExtension: "mp3")
        AudioServicesCreateSystemSoundID(soundURL2, &missSound)
        
        
 
  self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        self.navigationController?.pushViewController(_player1ViewController, animated: true)
        self.navigationController?.navigationItem.leftBarButtonItem?.title = "Quit"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //update game state according to the missile strike
    func getRowAndColumn (row: Character, column: Int)
    {
        //if the it's player1's turn, intake a missile into player 2's grid and vice versa
        if(_gameModel.P1Turn)
        {
            if(_gameModel.Player2Grid.intakeMissile(row, column: column))
            {
                _gameModel.Player2Fleet.decrementHp()
                if(_gameModel.Player2Fleet.isDestroyed)
                {
                    delegate?.AppStateChanged("gameOver1")
                }
                // Play sound
                AudioServicesPlaySystemSound(explodeSound);
                
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("Ok");
                alertView.title = "Missile Launched";
                alertView.message = "HIT!!!";
                alertView.show();
                
            }
            else
            {
                // Play sound
                AudioServicesPlaySystemSound(missSound);
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("Ok");
                alertView.title = "Missile Launched";
                alertView.message = "Miss :(";
                alertView.show();
                
            }

      
        }
        else
        {
            if(_gameModel.Player1Grid.intakeMissile(row, column: column))
            {
                _gameModel.Player1Fleet.decrementHp()
                if(_gameModel.Player1Fleet.isDestroyed)
                {
                   delegate?.AppStateChanged("gameOver2")
                }
                // Play sound
                AudioServicesPlaySystemSound(explodeSound);
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("Ok");
                alertView.title = "Missile Launched";
                alertView.message = "HIT!!!";
                alertView.show();
            }
            else
            {
                // Play sound
                AudioServicesPlaySystemSound(missSound);
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("Ok");
                alertView.title = "Missile Launched";
                alertView.message = "miss :(";
                alertView.show();
                
            }
    
        }
  
        _gameModel.P1Turn = !_gameModel.P1Turn
        
        _player1ViewController._underlyingView._yourHP.text = "You: " + _gameModel.Player1Fleet.healthAsPercentage() + "%"
        _player1ViewController._underlyingView._enemyHP.text = "Enemy: " + _gameModel.Player2Fleet.healthAsPercentage() + "%"
        
        
        _player2ViewController._underlyingView._yourHP.text = "You: " + _gameModel.Player2Fleet.healthAsPercentage() + "%"
        _player2ViewController._underlyingView._enemyHP.text = "Enemy:" + _gameModel.Player1Fleet.healthAsPercentage() + "%"
        
        _player1ViewController._opponentGrid = _gameModel.Player2Grid._grid
        _player1ViewController._yourGrid = _gameModel.Player1Grid._grid
        
        _player2ViewController._opponentGrid = _gameModel.Player1Grid._grid
        _player2ViewController._yourGrid = _gameModel.Player2Grid._grid
        
        
        
        self.navigationController?.popViewControllerAnimated(false)
        self.navigationController?.pushViewController(_transitionViewController, animated: false)
        
    }
    
    func AppStateChanged(reason: String)
    {
        self.navigationController?.popViewControllerAnimated(true)
        if(_gameModel.P1Turn)
        {
            self.navigationController?.pushViewController(_player1ViewController, animated: true)
        }
        else
        {
            self.navigationController?.pushViewController(_player2ViewController, animated: true)
        }
    }


}
