//
//  ViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/27/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateUpdateResponder {

    var underlyingView: SplashView?
    var _gameController: GameViewController = GameViewController()
    var _listController: GamesListViewController = GamesListViewController()
    var _placementController: ShipPlacementController = ShipPlacementController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    override func loadView()
    {
        underlyingView = SplashView()
        underlyingView?.delegate = self
        view = underlyingView
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = "Start"
    }
    
    func AppStateChanged(reason: String) {
        
        switch(reason)
        {
        case "new":
            self.navigationController?.pushViewController(_placementController, animated: true)
        
        case "list":
            self.navigationController?.pushViewController(_listController, animated: true)
          
        default:
            return
            
        }
    }

    

}

