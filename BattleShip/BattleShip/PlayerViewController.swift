//
//  GamePlayController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/7/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

//View controller used to control game play for player 1 and player 2
class PlayerViewController: UIViewController,  GridViewRegistrant, ShipGridProvider
{

  
    var _underlyingView: GamePlayView = GamePlayView()
  
    var _opponentGrid: [String] = []
    var _yourGrid: [String] = []
    var playerLabel: String = ""
    
    weak var delegate: GridViewRegistrant?
    weak var saveDelegate: AppStateUpdateResponder?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        _underlyingView._youGrid.DrawSquaresForShipsFromGrid(_yourGrid)
        _underlyingView._opponentGrid.DrawLaunchesFromGrid(_opponentGrid)
        
        var saveButton: UIBarButtonItem = UIBarButtonItem(title: "Save", style:UIBarButtonItemStyle.Plain, target: self, action: "writeToFile")
        

        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.leftBarButtonItem?.title = "Quit"
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    }

    override func loadView()
    {

        view = _underlyingView
        _underlyingView.delegate = self
        _underlyingView._opponentGrid.gridDelegate = self
        _underlyingView.setPlayerLabelText(playerLabel)
  

        self.title = "Battle!"
    }
    
    //update game state according to the missile strike
    func getRowAndColumn (row: Character, column: Int)
    {
        delegate?.getRowAndColumn(row, column: column)
    }
    
    func supplyShipGrid()
    {
       _underlyingView._youGrid.DrawSquaresForShipsFromGrid(_yourGrid)
       _underlyingView._opponentGrid.DrawLaunchesFromGrid(_opponentGrid)
        
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
    
    func writeToFile()
    {
        var alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "Save";
        alertView.message = "Game Saved";
        alertView.show();
        saveDelegate?.AppStateChanged("saveNow")
    }

}
