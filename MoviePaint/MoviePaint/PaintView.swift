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
    
    private func collectPointFromTouch(touch: UITouch)
    {
        let touchPoint: CGPoint = touch.locationInView(self)
        _points.append(touchPoint)
         setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        collectPointFromTouch(touches.anyObject() as UITouch)
        println("Polyline began with count \(_points.count)")
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
        
        let context: CGContext = UIGraphicsGetCurrentContext()
        //hint given at time this was typed
        for(var pointIndex: Int = 0; pointIndex < _points.count; pointIndex++)
        {
                   let point: CGPoint = _points[pointIndex]
            if(pointIndex == 0)
            {
         
                if(pointIndex == 0)
                {
                    CGContextMoveToPoint(context, point.x, point.y)
                    
                }
                else
                {
                    CGContextAddLineToPoint(context, point.x, point.y)
                }
                
                CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
                CGContextDrawPath(context, kCGPathFillStroke)
           
            }
           
        }
        
    }
    
    
}
