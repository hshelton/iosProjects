//
//  DetailViewController.swift
//  Lists
//
//  Created by Hayden Shelton on 2/16/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    
    var detailView: UILabel {return view as UILabel}
    
    override func loadView()
    {
        view = UILabel()
    }
    
    override func viewDidLoad()
    {
  
        detailView.textAlignment = NSTextAlignment.Center
        detailView.backgroundColor = UIColor.whiteColor()
    }
}
