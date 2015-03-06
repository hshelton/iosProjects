//
//  GameViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
{

    
    var underlyingView: GridView = GridView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        underlyingView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.85, alpha: 1.0)
        underlyingView.frame = CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 256)
    }
    
    override func loadView()
    {
       
        view = underlyingView
      
        
    }
   
    
}