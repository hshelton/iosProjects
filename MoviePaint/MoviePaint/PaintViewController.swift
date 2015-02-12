//
//  ViewController.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController {
    
    //gives outside classes ability to mess with the paint view
    var paintView: PaintView {return view as PaintView}
    
    
    override func loadView()
    {
        view = PaintView()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
}

