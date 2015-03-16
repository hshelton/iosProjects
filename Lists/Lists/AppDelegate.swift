//
//  AppDelegate.swift
//  Lists
//
//  Created by Hayden Shelton on 2/14/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = UINavigationController(rootViewController: ListViewController()) // set up the root controller as an instance of ViewController
        window?.makeKeyAndVisible()
        return true
    }

   


}

