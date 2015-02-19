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
    
    //view maintains seperate structure. this will move to the model at touch end?
    private var _points: [CGPoint] = []
    
    //should be able to retrieve the polylines from the data model and fil in the contents of the drawing
    //also should be able to take the polylines from the view and put them into the data model (by way of controller)
    private var _polylines: [[CGPoint]] = []
    
    
    var percentDrawn: Float = 0.0 //changes according to the scrubber slider
    
    var strokeColor: CGColor = UIColor.blackColor().CGColor
    
    private func collectPointFromTouch(touch: UITouch)
    {
        let touchPoint: CGPoint = touch.locationInView(self)
        _points.append(touchPoint)
       // setNeedsDisplay()
    
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
        
        _polylines.append(_points)
        setNeedsDisplay()
        _points = [] //clear out points
        
        
        
        //TODO: call delegate method with polyline that was just completed
    }
    
    override func drawRect(rect: CGRect) {
        //TODO: this method will iterate through the polylines and draw them to the screen
        
        backgroundColor = UIColor.whiteColor()
        
        let context: CGContext = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, strokeColor)
        CGContextSetLineWidth(context, 8.0)
        CGContextSetLineCap(context, CGLineCap(1))
        //CGContextSetLineCap(context, CGLineCap)

        
        //hint given at time this was typed
        
        /*
        for(var pointIndex: Int = 0; pointIndex < _points.count; pointIndex++)
        {
            //let point: CGPoint = _points[pointIndex]
            let point: CGPoint = _points[pointIndex]
            
            if(pointIndex == 0 )
            {
                
                CGContextMoveToPoint(context, point.x, point.y)
                
            }
            else
            {
                CGContextAddLineToPoint(context, point.x, point.y)
            }
        }
        
        CGContextDrawPath(context, kCGPathStroke)
        */
        
        
        /* optional way of drawing
        */
        for(var pLIndex:Int = 0; pLIndex < _polylines.count; pLIndex++)
        {

            for(var pointIndex: Int = 0; pointIndex < _polylines[pLIndex].count; pointIndex++)
            {
                //let point: CGPoint = _points[pointIndex]
                let point: CGPoint = _polylines[pLIndex][pointIndex]
                
                if(pointIndex == 0 )
                {
          
                    CGContextMoveToPoint(context, point.x, point.y)
            
                }
                else
                {
                    CGContextAddLineToPoint(context, point.x, point.y)
                }
            }
        
                CGContextDrawPath(context, kCGPathStroke)
        }
        
    
    }
    
    
    
}
