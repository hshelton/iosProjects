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
    
    private var minXSliderValue: CGFloat = 0.0
    private var maxXSliderValue: CGFloat = 0.0
    private var sliderXOffset: CGFloat = 0.0
    
    
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
        
        
        //draw the track bar as a rectangle
        _trackRect.size.height = bounds.height / 8
        _trackRect.origin.y = bounds.height / 2 - _trackRect.size.height/2
        _trackRect.origin.x = bounds.width * 0.025
        _trackRect.size.width = bounds.width * 0.95
        CGContextAddRect(context, _trackRect)
        CGContextSetFillColorWithColor(context, UIColor.darkGrayColor().CGColor)
        CGContextDrawPath(context, kCGPathFill)
        
        //draw the thumb bar as a rectangle
        _thumbRect.size.height = _trackRect.size.height * 3
        _thumbRect.origin.y = bounds.height / 2 - _trackRect.size.height * 1.5
        _thumbRect.origin.x = bounds.width * 0.025 + sliderXOffset
        _thumbRect.size.width = _trackRect.size.width / 8
        CGContextAddRect(context, _thumbRect)
        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextDrawPath(context, kCGPathFill)
        
        maxXSliderValue = _thumbRect.maxX
        minXSliderValue = _thumbRect.minX
        
        
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        let touch : UITouch = touches.anyObject() as UITouch //we know touch is a UITouch so cast it
        //where was that touch
        let touchPoint : CGPoint = touch.locationInView(self)
       sliderXOffset = min(touchPoint.x, maxXSliderValue)
        setNeedsDisplay()

        
        
    }
    
    
}
//objects who want to communicate with the valueSlider should conform to this protocol
protocol ValueSliderDelegate : class
{
    func valueChanged(slider: ValueSlider, value:ValueSlider)
}