//
//  TransitionController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/21/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class TransitionController: UIViewController, AppStateUpdateResponder
{
    
    
    var underlyingView: TransitionView = TransitionView()
    weak var delegate: AppStateUpdateResponder? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        underlyingView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.85, alpha: 1.0)
        
        title = "Pass Device"
    }
    
    override func loadView()
    {
        
        view = underlyingView
        underlyingView.delegate = self
        
        
    }
    
    func AppStateChanged(reason: String) {
        switch(reason)
        {
        case "ready":
            delegate?.AppStateChanged("ready")

        default:
            return
            
        }
    }
    
}