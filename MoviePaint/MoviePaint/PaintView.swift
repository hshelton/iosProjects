//
//  PaintView.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class PaintView : UIView
{
    private var _points: [CGPoint] = []
    private var _polylines: [[CGPoint]] = []
    private var _pointZero = false //dictates when to start a new path
    
    private func collectPointFromTouch(touch: UITouch)
    {
        let touchPoint: CGPoint = touch.locationInView(self)
        _points.append(touchPoint)
        setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        collectPointFromTouch(touches.anyObject() as UITouch)
        println("Polyline began with count \(_points.count)")
           _pointZero = true
         setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        collectPointFromTouch(touches.anyObject() as UITouch)
        println("Polyline moved with count \(_points.count)")
         setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
         collectPointFromTouch(touches.anyObject() as UITouch)
        println("Polyline ended with count \(_points.count)")
     
        setNeedsDisplay()
        
        //TODO: call delegate method with polyline that was just completed
    }
    
    override func drawRect(rect: CGRect) {
        //TODO: this method will iterate through the polylines and draw them to the screen
        let context: CGContext = UIGraphicsGetCurrentContext()
          CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
        
        //hint given at time this was typed
     
        for(var pointIndex: Int = 0; pointIndex < _points.count; pointIndex++)
        {
            let point: CGPoint = _points[pointIndex]
            
            if(pointIndex == 0 )
            {
          
                CGContextMoveToPoint(context, point.x, point.y)
            
            }
            else
            {
                //append the point and draw a line
                if(!_pointZero)
                {
                    CGContextAddLineToPoint(context, point.x, point.y)
                    CGContextStrokePath(context)
                    CGContextMoveToPoint(context, point.x, point.y)
                }
                else
                {
                    CGContextClosePath(context)
                    CGContextMoveToPoint(context, point.x, point.y)
                  
                    _pointZero = false
                }

            
            }

        }
     
        
    }
    
    
}
