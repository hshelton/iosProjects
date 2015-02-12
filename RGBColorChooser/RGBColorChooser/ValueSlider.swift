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
    
    private var maxV: Int = 255
    private var minV: Int = 0
    private var value: Int = 0
    
    var _trackRect: CGRect = CGRectZero
    var _thumbRect: CGRect = CGRectZero
    var thumbColor: CGColor = UIColor.blackColor().CGColor
    var trackColor: CGColor = UIColor.darkGrayColor().CGColor
    
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
        _trackRect.origin.x = bounds.width * 0.05
        _trackRect.size.width = bounds.width * 0.90
        CGContextAddRect(context, _trackRect)
        CGContextSetFillColorWithColor(context, trackColor)
        CGContextDrawPath(context, kCGPathFill)
        
        //draw the thumb bar as a rectangle
        _thumbRect.size.height = _trackRect.size.height * 3
        _thumbRect.origin.y = bounds.height / 2 - _trackRect.size.height * 1.5
        _thumbRect.origin.x = bounds.width * 0.025 + sliderXOffset
        _thumbRect.size.width = _trackRect.size.width / 8
        CGContextAddRect(context, _thumbRect)
        CGContextSetFillColorWithColor(context, thumbColor)
        CGContextDrawPath(context, kCGPathFill)
        
        maxXSliderValue = _trackRect.maxX - (_thumbRect.width + 0.025 * bounds.width)
        minXSliderValue = _trackRect.minX
        
        
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        let touch : UITouch = touches.anyObject() as UITouch //we know touch is a UITouch so cast it
        //where was that touch
        let touchPoint : CGPoint = touch.locationInView(self)
      
        if(touchPoint.x > maxXSliderValue )
        {
            sliderXOffset = maxXSliderValue
           
        }
        else if(touchPoint.x < CGFloat(minV))
        {
            sliderXOffset = 0
            _trackRect.origin.x = bounds.width * 0.025
            value = 0
        }
        else
        {
            sliderXOffset = touchPoint.x
        }
        setNeedsDisplay()

        let range:CGFloat = maxXSliderValue - minXSliderValue
        
        
        let ans: CGFloat = round (CGFloat(maxV) * CGFloat(sliderXOffset) / CGFloat(maxV))
        if(Int(ans) > maxV)
        {
            value = maxV
        }
 
        else
        {
          value = Int(ans)
        }
        
        
       // println(value)
        delegate?.valueChanged(self, value: value)
        
        
        
    }
    
    
}
//objects who want to communicate with the valueSlider should conform to this protocol
protocol ValueSliderDelegate : class
{
    func valueChanged(slider: ValueSlider, value: Int)
}