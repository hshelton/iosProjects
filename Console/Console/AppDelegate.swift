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
class AppDelegate: UIResponder, UIApplicationDelegate, ParentViewDelegate{

    var window: UIWindow?
    
    //do this upon application launch
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible() //if when I unwrap window and it's nill do no op
        window?.backgroundColor = UIColor.grayColor()
        
      // var baseView: ParentView = ParentView(frame: window!.frame)
       // baseView.delegate = self //delegate conformity
       // window?.addSubview(baseView)
        
        let slider : CustomSlider = CustomSlider(frame:CGRectZero)
        slider.frame = CGRect(x: 10.0, y: 64.0, width: window!.frame.width * 0.9, height: 32.0)
        slider.backgroundColor = UIColor.redColor()
        window?.addSubview(slider)
        
        return true
    }
    
        func parentView(parentView: ParentView, redvalueselected redVal: CGFloat, greenvalueselected greenVal: CGFloat, bluevalueselected blueVal: CGFloat) {
        println("red \(redVal) green \(greenVal) blue \(blueVal)")
        
        
    }
    
}

