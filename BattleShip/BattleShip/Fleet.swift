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
    
}

class Carrier: Ship
{
    override init()
    {
    super.init()
   _size = 5
   _hp = 5
    }
}

class BattleShip: Ship
{
    override init()
    {
        super.init()
        _size = 4
        _hp = 4
    }
}

class Submarine: Ship
{
    override init()
    {
        super.init()
        _size = 3
        _hp = 3
    }
}

class Destroyer: Ship
{
    override init()
    {
        super.init()
        _size = 3
        _hp = 3
    }
}
class Patrol: Ship
{
    override init()
    {
        super.init()
        _size = 2
        _hp = 2
    }
}

class Fleet
{
    var fleetCarrier: Carrier = Carrier()
    var fleetBattleShip: BattleShip = BattleShip()
    var fleetSubMarine: Submarine = Submarine()
    var fleetDestroyer: Destroyer = Destroyer()
    var fleetPatrol: Patrol = Patrol()
    
    var isDestroyed: Bool
    {
        return (fleetCarrier._hp == 0 && fleetBattleShip._hp == 0 && fleetSubMarine._hp == 0 && fleetDestroyer._hp == 0 && fleetPatrol._hp == 0)
    }
    
    var shipsRemaining: Int
    {
        var count = 0
        if(fleetCarrier._hp != 0) {count++}
        if(fleetBattleShip._hp != 0) {count++}
        if(fleetSubMarine._hp != 0) {count++}
        if(fleetDestroyer._hp != 0) {count++}
        if(fleetPatrol._hp != 0) {count++}
        
        return count
    }

    
}
