//
//  SubviewManager.swift
//  RGBColorChooser
//
//  Created by u0658884 on 2/9/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit


class SubviewManager : UIView
{
    private var _redSlider : ValueSlider! = nil
    private var _blueSilder : ValueSlider! = nil
    private var _greenSlider: ValueSlider! = nil
    private var _alphaSlider: ValueSlider! = nil
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        var sliderFrame: CGRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height/4)
        _redSlider = ValueSlider(frame : sliderFrame)
        _redSlider.backgroundColor = UIColor.whiteColor()
        addSubview(_redSlider)
        
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }
    
    
}
