//
//  ValueSlider.swift
//  RGBColorChooser
//
//  Created by u0658884 on 2/9/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class ValueSlider : UIView
{
    //used for parent view to keep track of it's ValueSlider(s)
    private var name: String! = nil
    
    private var max: Int = 255
    private var min: Int = 0
    private var value: Int = 0
    
    var _trackRect: CGRect = CGRectZero
    var _thumbRect: CGRect = CGRectZero
    var _knobRect: CGRect = CGRectZero
    
    //delegate property
    weak var delegate: ValueSliderDelegate? = nil
    
    func setName (_name: String)
    {
        name = _name
    }
    
    func getName () ->String
    {
        return name
    }
    


    //dirty portion of the view that gets redrawn
    override func drawRect(rect: CGRect)
    {
        let context: CGContext = UIGraphicsGetCurrentContext()
        let width: CGFloat = bounds.width
        let height: CGFloat = bounds.height
        
        if(width < height)
        {
            _trackRect.size.width = width/4
            _trackRect.size.height = width
        }
        else
        {
            _trackRect.size.width = height/4
            _trackRect.size.height = height
        }
        
       // CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
     //   CGContextAddRect(context, _trackRect)
      //  CGContextDrawPath(context, kCGPathFill)
     //
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextAddLineToPoint(context, 3.2, 45.0)
        CGContextDrawPath(context, kCGPathFillStroke)
        
    }
    
    
    
}
//objects who want to communicate with the valueSlider should conform to this protocol
protocol ValueSliderDelegate : class
{
    func valueChanged(slider: ValueSlider, value:ValueSlider)
}