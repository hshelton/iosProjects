//
//  AppDelegate.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //setting the root view controller to an instance of PaintViewController
        window?.rootViewController = UINavigationController(rootViewController: PaintViewController())
      //  window?.rootViewController = PaintViewController()
        window?.makeKeyAndVisible()
        
        return true
    }




}

