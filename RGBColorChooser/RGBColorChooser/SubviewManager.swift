//
//  SubviewManager.swift
//  RGBColorChooser
//
//  Created by u0658884 on 2/9/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit


class SubviewManager : UIView, ValueSliderDelegate
{
    private var _redSlider : ValueSlider! = nil
    private var _blueSlider : ValueSlider! = nil
    private var _greenSlider: ValueSlider! = nil
    private var _alphaSlider: ValueSlider! = nil
    private var bg : UIColor = UIColor.whiteColor()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
 
        _redSlider = ValueSlider(frame: frame)
        _redSlider.setName("red")
        _redSlider.backgroundColor = bg
        _redSlider.thumbColor = UIColor.redColor().CGColor
        _redSlider.delegate = self
        addSubview(_redSlider)
        
        _blueSlider = ValueSlider(frame: frame)
        _blueSlider.setName("blue")
        _blueSlider.backgroundColor = bg
        _blueSlider.thumbColor = UIColor.blueColor().CGColor
         _blueSlider.delegate = self
        addSubview(_blueSlider)
        
        _greenSlider = ValueSlider(frame: frame)
        _greenSlider.setName("blue")
        _greenSlider.backgroundColor = bg
        _greenSlider.thumbColor = UIColor.greenColor().CGColor
         _greenSlider.delegate = self
        addSubview(_greenSlider)
        
        _alphaSlider = ValueSlider(frame: frame)
        _alphaSlider.setName("black")
        _alphaSlider.backgroundColor = bg
        _alphaSlider.thumbColor = UIColor.blackColor().CGColor
         _alphaSlider.delegate = self
        addSubview(_alphaSlider)
        
    }
    
   override func layoutSubviews() {
        var r: CGRect = bounds
    
    (_redSlider.frame, r) = r.rectsByDividing(r.height/6, fromEdge: CGRectEdge.MinYEdge)
    (_blueSlider.frame, r) = r.rectsByDividing(r.height/5, fromEdge: CGRectEdge.MinYEdge)
    (_greenSlider.frame, r) = r.rectsByDividing(r.height/4, fromEdge: CGRectEdge.MinYEdge)
    (_alphaSlider.frame, r) = r.rectsByDividing(r.height/3, fromEdge: CGRectEdge.MinYEdge)
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }
    
    
    
   func valueChanged(slider: ValueSlider, value: Int)
   {
    println(value)
    }
    
}
