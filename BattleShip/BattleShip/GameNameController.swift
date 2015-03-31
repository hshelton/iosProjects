//
//  GameNameController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/29/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit
protocol GameChosenResponder: class
{
    func signalCreateGame(gameName: String, playerName: String)
    func signalJoinGame(playerName: String, id: String)
}

class gameNameController: UIViewController, UITextFieldDelegate
{
    var _underlyingView: GameNamerView = GameNamerView()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        _underlyingView.gameNameInput.delegate = self
        _underlyingView.playerNameInput.delegate = self

    }
    
    override func loadView()
    {
        
        view = _underlyingView
      
        self.title = "Name your Game"
    }
    
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    
    
    
    
    
    
    
}
