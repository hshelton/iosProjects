//
//  GamePlayController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/7/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

//View controller used to control game play for player 1 and player 2
class PlayerViewController: UIViewController,  GridViewRegistrant
{

  
    var _underlyingView: GamePlayView = GamePlayView()
  
    var _opponentGrid: [String] = []
    var _yourGrid: [String] = []
    var playerLabel: String = ""
    
    weak var delegate: GridViewRegistrant?
    weak var getGridsDelegate: AppStateUpdateResponder?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        _underlyingView.delegate = self
     
    }

    override func loadView()
    {

        view = _underlyingView
        self.title = "Battle!"
    }
    
    //update game state according to the missile strike
    func getRowAndColumn (row: Character, column: Int)
    {
        //tell the application view controller to attempt a guess
        delegate?.getRowAndColumn(row, column: column)
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
