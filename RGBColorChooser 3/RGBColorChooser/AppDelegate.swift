//
//  AppDelegate.swift
//  RGBColorChooser
//
//  Created by u0658884 on 2/9/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
   
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible() //if when I unwrap window and it's nill do no op
        
        let baseView: SubviewManager = SubviewManager(frame: window!.frame)
        baseView.backgroundColor = UIColor.darkGrayColor()
        
        window?.addSubview(baseView)
        
        
        
        
        
        
        
        return true
    }



}

