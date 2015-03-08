//
//  GamesListViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class GamesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    //this is the view that this controller manipulates
    var tableView: UITableView {return view as UITableView}
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
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let item: String = "A played Game"
        var cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell))
        cell.textLabel?.text = item
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    //implementing the protocol required functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
}
