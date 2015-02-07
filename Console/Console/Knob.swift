//
//  Knob.swift
//  Console
//
//  Created by u0658884 on 2/7/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

/*
* A user controlled circular knob for selecting and controlling values
*
*/
class Knob : UIView
{
    private var _knobRect: CGRect = CGRectZero
    var angle: Float = 3 * Float(M_PI)/2.0 // the angle of the nib
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        let touch : UITouch = touches.anyObject() as UITouch //we know touch is a UITouch so cast it
        //where was that touch
        let touchPoint : CGPoint = touch.locationInView(self)
        let touchAngle : Float = atan2(Float(touchPoint.y - _knobRect.midY), Float(touchPoint.x - _knobRect.midX))
        
        angle = touchAngle
        setNeedsDisplay()
    }
    
    //dirty portion of the view that gets redrawn
  override func drawRect(rect: CGRect)
  {
    let context: CGContext = UIGraphicsGetCurrentContext()
    
    _knobRect = CGRectZero //rectangle whose origin is 0,0 and 0x0 dimension
    _knobRect.size.width = min(bounds.width, bounds.height)
    _knobRect.size.height = _knobRect.width
    _knobRect.origin.x = (bounds.width - _knobRect.width) * 0.5
    _knobRect.origin.y = (bounds.height - _knobRect.height) * 0.5
    
    
    CGContextAddEllipseInRect(context, _knobRect) //draw the elipse inside _knobRect
    CGContextSetFillColorWithColor(context, UIColor.lightGrayColor().CGColor)
    CGContextDrawPath(context, kCGPathFill)
    

    
    let nibRadius: CGFloat = _knobRect.width*0.4
    
    var nibRect = CGRectZero
    nibRect.size.width = _knobRect.width * 0.15
    nibRect.size.height = nibRect.size.width
    nibRect.origin.x = _knobRect.midX + nibRadius * CGFloat(cosf(angle))-nibRect.width * 0.5
    nibRect.origin.y = _knobRect.midY + nibRadius * CGFloat(sinf(angle))-nibRect.height * 0.5
    
    CGContextAddEllipseInRect(context, nibRect) //draw the elipse inside _knobRect
    CGContextSetRGBStrokeColor(context, 255.0, 255.0, 255.0, 0.7)
    CGContextSetLineWidth(context, 5.0)
    
    CGContextDrawPath(context, kCGPathStroke)
    
  }
    
}
