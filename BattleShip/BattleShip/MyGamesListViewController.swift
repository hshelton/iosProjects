//
//  GamesListViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit



class MyGamesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //this is the view that this controller manipulates
    var tableView: UITableView {return view as UITableView}
    
    
    weak var appDel: AppStateUpdateResponder? = nil
    weak var gameJoinDel:GameChosenResponder? = nil
    weak var gameStartDel: gameInitializeResponder? = nil
    
    var serverGameManager = ServerGameManager()
    var timer: NSTimer? = nil
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "My Games"
        serverGameManager.refreshGamesList()
        tableView.dataSource = self
        tableView.delegate = self

        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        
    }
    
    func update()
    {
     
        serverGameManager.refreshMyGamesList()
        
    }
    override func loadView()
    {
        serverGameManager.refreshGamesList()
        view = UITableView(frame: CGRectZero, style:UITableViewStyle.Grouped)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell))
        var gameForCell = serverGameManager.getGameForCellAtIndexForMyGames(indexPath.item)
        cell.textLabel?.text = "\(gameForCell.name): \(gameForCell.status)"
        return cell
    }
    
    //implementing the protocol required functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        return serverGameManager.getMyGameCount()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        var entry: NSDictionary = serverGameManager.getServerParamsForGameAtIndex(indexPath.item)
        var gameID: String = entry["gameId"] as String
        var playerID: String = entry["playerId"] as String
        
        gameStartDel?.initGame(gameID, playerGUID: playerID)
    
        
    }
    
    

}


