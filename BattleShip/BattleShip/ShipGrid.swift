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
            while(currentCell < t._size)
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
            
        }
            
        else
        {
            var rows: [Int] = []
            var currentCell: Int = getIntValue(row)
            
            //get list of rows that we want to place in
            while(currentCell < t._size)
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
                SetContentsOfGridCellWithIntRow(r, col: col, contents: "s")
            }

        }
        
        return false
    }
    
    
}