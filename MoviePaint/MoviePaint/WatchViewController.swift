//
//  WatchViewController.swift
//  MoviePaint
//
//  Created by u0658884 on 2/20/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit



class WatchViewController: UIViewController{


    override func loadView()
    {
        var toLoad : WatchBaseView = WatchBaseView()
        toLoad.backgroundColor = UIColor.whiteColor()
        //toLoad.delegate = self
        view = toLoad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func valueChanged(slider: UISlider, value: Float)
    {
        //trigger a redraw
    }
    
    
    
}
