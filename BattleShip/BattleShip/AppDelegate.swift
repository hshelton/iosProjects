//
//  AppDelegate.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var testGrid: GameGrid = GameGrid()
        
        testGrid.GetContentsOfGridCell(Character("b"), col: 10)
       
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        var grid: GridView = GridView(frame: window!.frame)
        grid.backgroundColor = UIColor.whiteColor()
        window?.addSubview(grid)
        
        
        return true
    }



}

