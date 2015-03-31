//
//  GamesListViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

protocol gameLoader:class
{
    func getGame(number: Int)
    func returnIP(number: Int) -> Bool
}

protocol gameInitializeResponder: class
{
    func initGame(gameGUID: String)
    
}
class GamesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
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
        title = "Lobby"
        tableView.dataSource = self
        tableView.delegate = self
        var newGameButton: UIBarButtonItem = UIBarButtonItem(title: "New Game", style:UIBarButtonItemStyle.Plain, target: self, action: "newGame")
        self.navigationItem.rightBarButtonItem = newGameButton
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
  
        
    }
    
    func update()
    {
        serverGameManager.globalCounter = 0
        serverGameManager.refreshGamesList()
        
        
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
        serverGameManager.loadGameIDsFromFile()
        serverGameManager.loadPlayerIDsFromFile()
        var gameForCell = serverGameManager.getGameForCellAtIndex(indexPath.item)
        if(gameForCell.status != "WAITING")
        {
            var gD: gameSummary = serverGameManager.getDetailsForGameAtIndex(indexPath.item)
            
            if(serverGameManager.isMyGame(gameForCell.id))
            {
                gameStartDel?.initGame(gameForCell.id)
            }
            else
            {
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
                summaryAlert.show()}
            
        }
        
        //otherwise the game is ready for me to join
        else
        {
            gameJoinDel?.signalJoinGame("Player2", id:gameForCell.id)
            
        }
        
        
    }

    
    //request new game
    func newGame()
    {
        appDel?.AppStateChanged("new")
    }
  


}


