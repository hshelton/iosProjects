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
    
     var _grid: [String] = []
    
    
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
     //   printGridForDebug()
        var cellInQuestion = res * 10 + col 
        return _grid[res * 10 + col ]
    }
    
    func GetContentsOfGridCellWithIntRow(row: Int, col: Int) -> String
    {
     
        if(row < 0 || row > 9 || col < 0 || col > 9)
        {
            return "error"
        }
     //
        //bug fix, now returns correct position
        return _grid[row * 10 + col ]
    }

    func SetContentsOfGridCell(row:Character, col: Int, contents:String) -> Bool
    {
        let res: Int = getIntValue(row)
        if(res == -1 || col < 0 || col > 9 || _grid[res * 10 + col] != "e")
        {
            return false
        }
        var index = _grid[res * 10 + col]
        _grid[res * 10 + col ] = contents
     

        return true
    }
    
    func SetContentsNotForPlacement(row: Character, col: Int, contents:String)
    {
        let res: Int = getIntValue(row)
        _grid[res * 10 + col ] = contents
    }
    
    func SetContentsOfGridCellWithIntRow(row:Int, col: Int, contents:String) -> Bool
    {
        
        if( row < 0 || row > 9 || col < 0 || col > 9 || _grid[row * 10 + col] != "e")
        {
            return false
        }
        _grid[row * 10 + col ] = contents
        

        return true
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
    
    func printGridForDebug()
    {
        println("BEG------GRID-------")
        var current: Int = 0
        for(var i: Int = 0; i < 10; i++)
        {
            for(var j: Int = 0; j < 10; j++)
            {
                print("[" +  (_grid[10 * current + j]) + "]")
                
            }
            println()
            current++
        }
        println("END------GRID-------")
    }
    
}