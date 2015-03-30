//
//  AppDelegate.swift
//  NetworkedBattleship
//
//  Created by Hayden Shelton on 3/29/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = UINavigationController(rootViewController: GameListViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

    


}

