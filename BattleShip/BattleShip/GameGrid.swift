//
//  GameGrid.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation


class GameGrid
{
    
    private var _grid: [String] = []
    
    
    
    init()
    {
       //the grid is initially a bunch of empty squares
        for(var i:Int = 0; i < 100; i++)
        {
            _grid.append("e")
        }
        
    }
    
    func GetContentsOfGridCell(row: Character, col: Int) -> String
    {
        let res:Int = getIntValue(row)
        if(res == -1 || col < 0 || col > 9)
        {
            return "error"
        }
        return _grid[res * col]
    }

    func SetContentsOfGridCell(row:Character, col: Int, contents:String) -> Bool
    {
        let res: Int = getIntValue(row)
        if(res == -1 || col < 0 || col > 9 || _grid[res * col] != "e")
        {
            return false
        }
        _grid[res * col] = contents
        return false
    }
    
    
    private func getIntValue(c: Character) ->Int
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