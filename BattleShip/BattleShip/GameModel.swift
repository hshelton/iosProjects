//
//  GameModel.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation
import QuartzCore

class Game {
    
    var Player1: Player = Player()
    var Player2: Player = Player()
    var Player1Fleet: Fleet = Fleet()
    var Player2Fleet: Fleet = Fleet()
    
    var Player1Grid: ShipGrid = ShipGrid()
    var Player2Grid: ShipGrid = ShipGrid()
    var Name: String = "Game001"
    var P1Turn: Bool = true
    init()
    {
     
    }
    
    

}