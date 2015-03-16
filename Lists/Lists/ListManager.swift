//
//  ListModel.swift
//  Lists
//
//  Created by Hayden Shelton on 2/14/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import Foundation


class ListModel
{
    //TODO: Get infromation from file into memory
    var itemCount: Int {return 500}
    
    
    func itemAtIndex(itemIndex: Int) -> String
    {
        return "Item: \(itemIndex)"
    }
    
    
}