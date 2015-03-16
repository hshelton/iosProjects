//
//  ViewController.swift
//  Lists
//
//  Created by Hayden Shelton on 2/14/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var list: ListModel = ListModel()
    
    //this is the view that this controller manipulates
    var tableView: UITableView {return view as UITableView}
    
    //called the first time any view loads, better to initialize the root view here than to load something and set it in viewDidLoad()
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
        
        title = "Item List"
        tableView.dataSource = self
        
        tableView.delegate = self
    }
    
    //override when view appears
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func supportedInterfaceOrientations() -> Int {
        
        return UIInterfaceOrientation.Portrait.rawValue |
        UIInterfaceOrientation.LandscapeLeft.rawValue |
        UIInterfaceOrientation.LandscapeRight.rawValue
    }
  //  override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
      
   // }
    
    
    //implementing the protocol required functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.itemCount
    }
    
    //passed in an index path it will reference a section and a row and you return a cell corresponding
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      
        let item: String = itemFromPath(indexPath)
        
        var cell: UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell))

        cell.textLabel?.text = item

        
        return cell
    }
    
     func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
     {
        //obtain item at row
        let item: String = itemFromPath(indexPath)
        
        //create a detail view controller to represent the item
        
        var detailViewController: DetailViewController = DetailViewController()
        
        detailViewController.title = item + " details"
    
        detailViewController.detailView.text = item + ": More specific details about this item appear here"
        
        if(navigationController == nil)
        {
            //add a back button!
       presentViewController(detailViewController, animated: true, completion: nil)
        }
        else
        {
            navigationController?.pushViewController(detailViewController, animated: true)
        }
     }

    
    private func itemFromPath(indexPath: NSIndexPath) -> String
    {
        let i: Int = indexPath.row
        return list.itemAtIndex(i)
    }
    
    
    
    
    
    
    
    
    
}

