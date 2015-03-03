//
//  GridView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/28/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit


class GridView: UIView
{

    //the rectangle that is selected
    var rectToDraw: CGRect = CGRectZero
    var redrawSelected: Bool = false
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //capture touch points in order to draw a rectangle that is colored and is located in the grid location they touched
  override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
  {
    let touch : UITouch = touches.anyObject() as UITouch
    let touchPoint : CGPoint = touch.locationInView(self)
    
    let width: CGFloat = bounds.width
    let height: CGFloat = bounds.height
    
    let xInterval: CGFloat = width / 10
    let yInterval: CGFloat = height / 10
    
    let xRounded: CGFloat = touchPoint.x - (touchPoint.x % xInterval)
   let yRounded: CGFloat = touchPoint.y - (touchPoint.y % yInterval)
    
    let chosen: CGRect = CGRect(x: xRounded, y: yRounded, width: xInterval, height: yInterval)
    
    rectToDraw = chosen
    redrawSelected = true
    setNeedsDisplay()
    }
    
    
   override func drawRect(rect: CGRect) {
  
    let context: CGContext = UIGraphicsGetCurrentContext()
    let width: CGFloat = bounds.width
    let height: CGFloat = bounds.height
    
    
 
    let interval: CGFloat = width / 10
    
    CGContextSetStrokeColorWithColor(context, UIColor.grayColor().CGColor)
    CGContextSetLineWidth(context, 1.5)
    
    CGContextMoveToPoint(context, 0.0, 0.0)
    
    //draw 10 columns
    for (var i: Int = 0; i < 10; i++)
    {
        var xPos: CGFloat = CGFloat(i) * interval
        CGContextAddLineToPoint(context, xPos, height)
        CGContextDrawPath(context, kCGPathStroke)
        
        CGContextMoveToPoint(context, xPos + interval, 0.0)
        
    }
    
    let interval2: CGFloat = height/10
    CGContextMoveToPoint(context, 0.0, 0.0)
    
    //draw 10 rows
    for (var i: Int = 0; i < 10; i++)
    {
        var yPos: CGFloat = CGFloat(i) * interval2
        CGContextAddLineToPoint(context, width, yPos)
        CGContextDrawPath(context, kCGPathStroke)
        
        CGContextMoveToPoint(context, 0.0, yPos + interval2)
        
    }
    
    
    if(redrawSelected)
    {
        CGContextAddRect(context, rectToDraw)
        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextDrawPath(context, kCGPathFill)
        redrawSelected = false
        
        
    }
    
    setNeedsDisplay()
    
    }
    
    
    
    

}
