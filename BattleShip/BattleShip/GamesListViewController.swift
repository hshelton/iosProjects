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
class GamesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //this is the view that this controller manipulates
    var tableView: UITableView {return view as UITableView}
    var numberofGameSaves = 0
    weak var delegate: gameLoader? = nil
    weak var appDel: AppStateUpdateResponder? = nil
    override func loadView()
    {
        view = UITableView(frame: CGRectZero, style:UITableViewStyle.Grouped)
    }
    
    //when the view is about to be shown for the first time
    //we will look into our data model to display things from it
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.redColor()
        //view = UITableView()
        title = "Load Game"
        tableView.dataSource = self
        tableView.delegate = self
        
        var newGameButton: UIBarButtonItem = UIBarButtonItem(title: "New Game", style:UIBarButtonItemStyle.Plain, target: self, action: "newGame")
        
        
        self.navigationItem.rightBarButtonItem = newGameButton
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let item: String = "Game " + String(indexPath.item)
        var cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell))
        cell.textLabel?.text = item
        
        var ip: Bool? = delegate?.returnIP(indexPath.item)
        if(ip!)
        {
            var text: String = item + " (ongoing)"
            cell.textLabel?.text = text
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //request that parent controller loads that game
        delegate?.getGame(indexPath.item)
    }
   
 
    //implementing the protocol required functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberofGameSaves
    }
    
    //request new game
    func newGame()
    {
        appDel?.AppStateChanged("new")
    }
  


}


