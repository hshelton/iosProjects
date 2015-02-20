//
//  ColorChooserController.swift
//  MoviePaint
//
//  Created by Hayden Shelton on 2/16/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

protocol colorUpdate:class
{
    func getUpdate(instance: ColorChooserController, colorSelected: UIColor)
    
}

class ColorChooserController: UIViewController, colorDelegate {
    
    //gives outside classes ability to mess with the color chooser view
    var colorChooserView: ChooserSubviewManager {return view as ChooserSubviewManager}
    var colorChosen: UIColor = UIColor.blackColor()
    
    override func loadView()
    {
        var toLoad : ChooserSubviewManager = ChooserSubviewManager()
        toLoad.delegate = self
        view = toLoad
        
    }
    
    weak var getUpdate: colorUpdate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    func chooserSubviewManager(SubviewManagerInstance: ChooserSubviewManager, colorSelected: UIColor)
    {
        colorChosen = colorSelected
        
        //invoke delegate
        getUpdate?.getUpdate(self, colorSelected: colorSelected)
    }
    
}

