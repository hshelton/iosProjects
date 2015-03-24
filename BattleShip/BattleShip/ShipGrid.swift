//
//  ShipGrid.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation


class ShipGrid: GameGrid
{
    let maxRowIndex: Int = 9
    let maxColIndex: Int = 9
   
    func InsertShip(t: Ship, row: Character, col: Int, horizontal: Bool) -> Bool
    {
        var ok: Bool = true
        if(horizontal)
        {
            var cols: [Int] = []
            var currentCell: Int = col
            
            //get list of cols that we want to place in
            while(cols.count < t._size)
            {
                cols.append(currentCell)
                currentCell++
            }
            //make sure they exist and are empty
            for c in cols{
            
                if(GetContentsOfGridCell(row, col: c) != "e") {return false}
            }
            //set the cells
            for c in cols{
                SetContentsOfGridCell(row, col: c, contents: "s")
            }
            printGridForDebug()
        }
            
        else
        {
            var rows: [Int] = []
            var currentCell: Int = getIntValue(row)
            
            //get list of rows that we want to place in
            while(rows.count < t._size)
            {
                rows.append(currentCell)
                currentCell++
            }
            //make sure they exist and are empty
            for r in rows{
            
                if(GetContentsOfGridCellWithIntRow(r, col: col) != "e") {return false}
            }
            //set the cells
            for r in rows {
                var set = SetContentsOfGridCellWithIntRow(r, col: col, contents: "s")
            }
            printGridForDebug()
        }
        return true
    }
    //register a missle strike in game grid
    // returns true if the missle was a strike
    func intakeMissile (row: Character, column: Int) -> Bool
    {
        var test = GetContentsOfGridCell(row, col: column)
        if(GetContentsOfGridCell(row, col: column) == "s")
        {
            SetContentsNotForPlacement(row, col: column, contents: "h")
            return true
        }
    
        if(GetContentsOfGridCell(row, col: column)=="h")
        {
            return false
        }
        if(GetContentsOfGridCell(row, col: column) == "e")
        {
            SetContentsNotForPlacement(row, col: column, contents: "m")
            return false
        }
        
        return false
    }
    
    //get count of grid cells that contain 's' for ship
    func getHPRemaining () -> Int
    {
        var count = 0
        for c in _grid
        {
            if(c == "s")
            {
                count++
            }
        }
        return count
    }
    
}