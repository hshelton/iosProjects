//
//  GamePlayController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/7/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

//View controller used to control game play for player 1 and player 2
class GamePlayController: UIViewController,  GridViewRegistrant
{
    var _opponentView: GridView = GridView()
    var _playerView: GridView = GridView()
  
    private var _underlyingView: UIView = GamePlayView()
    //logic to make sure that each ship is only placed once
    var _gameModel: Game?
    
    
    var _shipGrid: ShipGrid = ShipGrid() //keeps track of the ships that have been placed. later will be passed to the main controller
    private var sType: Ship = Carrier()
    private var horizontalInsert: Bool = false
    
    weak var delegate: AppStateUpdateResponder?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    override func loadView()
    {

        view = _underlyingView

        
        self.title = "Battle!"
    }
    
    
    func getRowAndColumn (row: Character, column: Int)
    {
       
    }
    
    
  
    
 
    

}
