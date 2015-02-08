//
//  AppDelegate.swift
//  Console
//
//  Created by u0658884 on 2/7/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

@UIApplicationMain
//AppDelegate corresponds to these two protocols
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //do this upon application launch
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible() //if when I unwrap window and it's nill do no op
        
        

        
        return true
    }



}

