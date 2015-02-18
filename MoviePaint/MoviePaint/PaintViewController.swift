//
//  ViewController.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController, colorUpdate {
    
    //gives outside classes ability to mess with the paint view
    var paintView: PaintView {return view as PaintView}
    var chooser: ColorChooserController = ColorChooserController()
    var underlyingView = PaintView()

    override func loadView()
    {
        
        //TODO: add steps 4 and 5 to register color updates
        
        view = underlyingView
        
        //underlyingView.backgroundColor = UIColor.whiteColor()
        
        
        var colorButton : UIBarButtonItem = UIBarButtonItem(title: "Color", style: UIBarButtonItemStyle.Plain, target: self, action: "popView")
        self.navigationController?.navigationBar.backgroundColor = chooser.colorChosen
        
        chooser.getUpdate = self
       
        
    
        self.navigationItem.leftBarButtonItem = colorButton
        
        
    }
    
    func popView ()
    {
        
        self.navigationController?.pushViewController(chooser, animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func getUpdate(instance: ColorChooserController, colorSelected: UIColor)
    {
        //TO DO: Set a display color box equal to chosen color
        //set paintview's color to color chosen
        underlyingView.strokeColor = colorSelected.CGColor
    
        
    }
    
    
}

