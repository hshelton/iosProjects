//
//  GameListViewController.swift
//  NetworkedBattleship
//
//  Created by Hayden Shelton on 3/29/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate
{
    //this is the view that this controller manipulates
    var tableView: UITableView {return view as UITableView}
    var serverGameManager = ServerGameManager()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Lobby"
        tableView.dataSource = self
        tableView.delegate = self
        var newGameButton: UIBarButtonItem = UIBarButtonItem(title: "New Game", style:UIBarButtonItemStyle.Plain, target: self, action: "newGame")
        self.navigationItem.rightBarButtonItem = newGameButton
        
    }
    
    override func loadView()
    {
        serverGameManager.refreshGamesList()
        view = UITableView(frame: CGRectZero, style:UITableViewStyle.Grouped)
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell))
        var gameForCell = serverGameManager.getGameForCellAtIndex(indexPath.item)
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
        var what = serverGameManager.getGameCount()
        return serverGameManager.getGameCount()
    }


    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var gameForCell = serverGameManager.getGameForCellAtIndex(indexPath.item)
        if(gameForCell.status != "WAITING")
        {
            var gD: gameSummary = serverGameManager.getDetailsForGameAtIndex(indexPath.item)
            
            var winner: String = gD.winner
            if(winner == "IN PROGRESS")
            {
                winner = "Game in progress."
            }
            else
            {
                winner += " has won the game"
            }
            
            var msg: String = "\(gD.player1) vs \(gD.player2) \n \(gD.missilesLaunched) missiles launched. \(winner)"
            
           var summaryAlert = UIAlertView(title: gD.name, message: msg, delegate: nil, cancelButtonTitle: "Close", otherButtonTitles: "OK")
            summaryAlert.show()
            
        }
        
    
    }
    
    func newGame()
    {
        
    }
    
    
   
}


