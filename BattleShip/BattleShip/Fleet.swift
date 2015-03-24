//
//  Fleet.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation

class Ship
{
    var _size: Int = 0
    var _hp: Int = 0
    var _type: String = "NA"
    
}

class Carrier: Ship
{
    override init()
    {
    super.init()
   _size = 5
   _hp = 5
   _type = "Carrier"
   
    }
}

class BattleShip: Ship
{
    override init()
    {
        super.init()
        _size = 4
        _hp = 4
        _type = "Battleship"
    }
}

class Submarine: Ship
{
    override init()
    {
        super.init()
        _size = 3
        _hp = 3
        _type = "Submarine"
    }
}

class Destroyer: Ship
{
    override init()
    {
        super.init()
        _size = 3
        _hp = 3
        _type = "Destroyer"
    }
}
class Patrol: Ship
{
    override init()
    {
        super.init()
        _size = 2
        _hp = 2
        _type = "Patrol"
    }
}

class Fleet
{
    var hp = 17
    
    var isDestroyed: Bool
    {
        return (hp == 0)
    }
    
    func decrementHp()
    {
        hp--
    }

    func healthAsPercentage()-> String
    {
        let hp1: Float = Float(hp)
        let rounded  = round((hp1/17 * 100))
        return String(format: "%.2f",rounded)
    }
    
}
