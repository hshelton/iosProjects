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
    
    
    struct coloredPointArray
    {
        var pointArray: [CGPoint] = []
        var color: CGColor = UIColor.blackColor().CGColor
        var count: Int {return pointArray.count}
    }
    //view maintains seperate structure. this will move to the model at touch end?
    private var _points: [CGPoint] = []
    
    //should be able to retrieve the polylines from the data model and fil in the contents of the drawing
    //also should be able to take the polylines from the view and put them into the data model (by way of controller)
    private var _polylines: [coloredPointArray] = []
    
    
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
        

        let toAdd: coloredPointArray  = coloredPointArray(pointArray: _points, color: self.strokeColor)
        _polylines.append(toAdd)
        setNeedsDisplay()
        _points = [] //clear out points
        
        
        
        //TODO: call delegate method with polyline that was just completed
    }
    
    override func drawRect(rect: CGRect) {
        //TODO: this method will iterate through the polylines and draw them to the screen
        
       
        let context: CGContext = UIGraphicsGetCurrentContext()
<<<<<<< HEAD
  
        CGContextSetLineWidth(context, 50.0)
=======
        CGContextSetStrokeColorWithColor(context, strokeColor)
        CGContextSetLineWidth(context, 8.0)
>>>>>>> FETCH_HEAD
        CGContextSetLineCap(context, CGLineCap(1))
        //CGContextSetLineCap(context, CGLineCap)

        
        //hint given at time this was typed
        
<<<<<<< HEAD
        //draw all the other lines
        for coloredPolyline in _polylines
        {
            CGContextSetStrokeColorWithColor(context, coloredPolyline.color)
            for(var pointIndex: Int = 0; pointIndex < coloredPolyline.count; pointIndex++)
            {
                //let point: CGPoint = _points[pointIndex]
                let point: CGPoint = coloredPolyline.pointArray[pointIndex]
                
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
        
        
        //draw current line
        CGContextSetStrokeColorWithColor(context, strokeColor)
=======
        /*
>>>>>>> FETCH_HEAD
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
