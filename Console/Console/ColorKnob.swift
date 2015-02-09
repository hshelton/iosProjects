//
//  Knob.swift
//  Console
//
//  Created by u0658884 on 2/7/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit


protocol ColorKnobDelegate: class
{
    
    func colorKnob(colorKnob: ColorKnob, getRedValue value: CGFloat)
    func colorKnob(colorKnob: ColorKnob, getGreenValue value: CGFloat)
    func colorKnob(colorKnob: ColorKnob, getBlueValue value: CGFloat)
}

/*
* A user controlled circular knob for selecting and controlling values
*
*/
class ColorKnob : UIView
{
     var _knobRect: CGRect = CGRectZero
    var angle: Float = 3 * Float(M_PI)/2.0 // the angle of the nib
    private let nibScale : CGFloat = 0.08
    var redVal: CGFloat = CGFloat(255.0)
    var greenVal: CGFloat = CGFloat(255.0)
    var blueVal: CGFloat = CGFloat(255.0)
    private var nibRadius: CGFloat = 0.0
     var _xCoord :CGFloat = 0.0
    var _yCoord :CGFloat = 0.0
    
    private var maxDistFromOrigin :CGFloat = 0.0
    private var nibOriginY : CGFloat = 0.0
    private var nibOriginX : CGFloat = 0.0
    
    //delegate property
    weak var delegate: ColorKnobDelegate? = nil
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        let touch : UITouch = touches.anyObject() as UITouch //we know touch is a UITouch so cast it
        //where was that touch
        let touchPoint : CGPoint = touch.locationInView(self)
        let touchAngle : Float = atan2(Float(touchPoint.y - _knobRect.midY), Float(touchPoint.x - _knobRect.midX))
        
        _xCoord = touchPoint.x
        _yCoord = touchPoint.y
        
        let maxRGB: CGFloat = CGFloat(255.0)
        
        //defines how the RGB values are calculated
        redVal = min(maxRGB, touchPoint.x )
        greenVal = min(maxRGB, touchPoint.y)
        blueVal = min(maxRGB, touchPoint.x)
       // angle = touchAngle
        setNeedsDisplay()
        delegate?.colorKnob(self, getRedValue : redVal)
        delegate?.colorKnob(self, getBlueValue : blueVal)
        delegate?.colorKnob(self, getGreenValue : greenVal)
        
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
        maxDistFromOrigin = _knobRect.size.width/2
        
          nibRadius = _knobRect.width*0.4
        
        var res = recalculateBounds(_xCoord,y:_yCoord, originx: nibOriginX, originy: nibOriginY)
        _xCoord = res.newx
        _yCoord = res.newy
        if(_xCoord == 0.0 && _yCoord == 0.0)
        {
            _xCoord = _knobRect.midX
            _yCoord = _knobRect.midY
        }
        
        //at this point we know _xCoord & _yCoord are within the bounds of the circle
        
        CGContextAddEllipseInRect(context, _knobRect) //draw the elipse inside _knobRect
        CGContextSetFillColorWithColor(context, UIColor.lightGrayColor().CGColor)
        CGContextDrawPath(context, kCGPathFill)
        
        var inscribe:CGRect = CGRectZero
        inscribe.origin.x = _knobRect.origin.x + _knobRect.size.width * 0.05 ; inscribe.origin.y = _knobRect.origin.y + _knobRect.size.width * 0.05
        inscribe.size.height = _knobRect.size.height * 0.9; inscribe.size.width = _knobRect.size.width * 0.9
        
        CGContextAddEllipseInRect(context, inscribe) //draw the elipse inside _knobRect
        //CGContextSetFillColorSpace(context, CGColorSpaceCreateDeviceRGB())
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
   
        CGContextDrawPath(context, kCGPathFill)
        //draw the rainbow inside of the inscribing circle
        let arcCenter: CGPoint = CGPoint(x:inscribe.midX, y:inscribe.midY); let radius:CGFloat = CGFloat(inscribe.width/4); let startAngle:CGFloat = CGFloat(0.0)
        let endAngle:CGFloat = CGFloat(360.0); let clockwise:Bool = true
        let bezierPath: CGPath = UIBezierPath(arcCenter:arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise).CGPath
        
        let cap : CGLineCap = CGLineCap(0); let join:CGLineJoin = CGLineJoin(1); let mLim: CGFloat = 4.0; let lWidth: CGFloat = inscribe.width/2
        let transform: UnsafePointer<CGAffineTransform> = UnsafePointer<CGAffineTransform>()
        //can transofrm remain nil?
        CGContextSetRGBStrokeColor(context, 3.0, 33.0, 2.0, 1.0)
        CGContextSetFillColorWithColor(context, UIColor.greenColor().CGColor)
        let arc:CGPath = CGPathCreateCopyByStrokingPath(bezierPath, transform, lWidth, cap, join, mLim)
        CGContextAddPath(context, arc)
        CGContextDrawPath(context, kCGPathFillStroke)
        
        
        
        var nibRect = CGRectZero
        nibRect.size.width = _knobRect.width * nibScale
        nibRect.size.height = nibRect.size.width
        nibRect.origin.x = _xCoord - nibRadius/2 * nibScale
        nibRect.origin.y = _yCoord - nibRadius/2 * nibScale
        
    
        
        if(nibOriginX == 0.0 && nibOriginY == 0.0)
        {
        nibOriginX = nibRect.origin.x
        nibOriginY = nibRect.origin.y
        }
        
        CGContextAddEllipseInRect(context, nibRect) //draw the elipse inside _knobRect
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 0.7)
        CGContextSetLineWidth(context, 20.0)
        CGContextDrawPath(context, kCGPathStroke)
        
  
        
        
        
        
    }
    
    //modifies x and y coordinates so that they fit within the range of the circle
    func recalculateBounds (x:CGFloat, y: CGFloat, originx: CGFloat, originy:CGFloat) ->(newx: CGFloat, newy: CGFloat)
    {
        //use distance formula to figure out if we need to reduce the x or y coord
        var x0 = originx; var y0 = originy; var x1 = x; var y1 = y
        
        var a = x1 - x0
        var b = y1 - y0
        
        var ans = sqrt(pow(a, 2) + pow(b, 2))
        var tempx :CGFloat = x
        var tempy :CGFloat = y
        if(ans > maxDistFromOrigin)
        {
           return (0.0, 0.0)
        }
        
        return (x, y)
        
    }
    
    
    
    

}

