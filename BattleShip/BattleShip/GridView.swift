//
//  GridView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 2/28/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

protocol GridViewRegistrant:class
{
    func getRowAndColumn (row: Character, column: Int)
}
protocol ShipGridProvider:class
{
    func supplyShipGrid()
}

class GridView: UIView
{
    weak var delegate: GridViewRegistrant? = nil
    weak var gridDelegate: ShipGridProvider? = nil
    //the rectangle that is selected
    var rectToDraw: CGRect = CGRectZero
    var redrawSelected: Bool = false
    var _row: Character = "z"
    var _column: Int = -1
    var never_redraw: Bool = false
    
    //the rectangles that make up validly placed ships
    var rectsToDraw: [CGRect] = []
    var missedSquares: [CGRect] = []
    var hitSquares: [CGRect] = []


    
    override init(frame: CGRect)
    {
        super.init(frame: frame)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init()
    {
        super.init()
    }
    
    
    //called by parent view controller add a few more rectangles to the left or below the last drawn
    func updateRectsToDraw(addXMore: Int, horizontal: Bool)
    {
        let width: CGFloat = bounds.width
        let height: CGFloat = bounds.height
        
        let xInterval: CGFloat = width / 10
        let yInterval: CGFloat = height / 10
        
        rectsToDraw.append(rectToDraw)
        
        if(horizontal)
        {
            for (var i: Int = 0; i < addXMore; i++)
            {
                let xOffset: CGFloat = rectToDraw.origin.x + (CGFloat(i) * xInterval)
                
                let current: CGRect = CGRect(x: xOffset, y: rectToDraw.origin.y, width: xInterval, height: yInterval)
                rectsToDraw.append(current)
            }
        }
        else
        {
        
            for (var i: Int = 0; i < addXMore; i++)
            {
                let yOffset: CGFloat = rectToDraw.origin.y + (CGFloat(i) * yInterval)
                let current: CGRect = CGRect(x: rectToDraw.origin.x, y: yOffset, width: xInterval, height: yInterval)
                rectsToDraw.append(current)
            }
        }
        setNeedsDisplay()
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
    updateSelected(xRounded, Y:yRounded, XInterval: xInterval, YInterval: yInterval)
    redrawSelected = true

     setNeedsDisplay()
    }
    
     override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        redrawSelected = false
        
        setNeedsDisplay()
    }

   override func drawRect(rect: CGRect) {
  
    let context: CGContext = UIGraphicsGetCurrentContext()
    let width: CGFloat = bounds.width
    let height: CGFloat = bounds.height
    
    let all: CGRect = CGRect(x: 0.0, y:0.0, width: width, height: height)
    
    //done to make sure we're redrawing everything
    CGContextAddRect(context, all)
    CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
    
    CGContextDrawPath(context, kCGPathFill)
    let interval: CGFloat = width / 10
    
    CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
    CGContextSetLineWidth(context, 0.5)
    
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
    
    }
    
    //tells those interested the new row and column
    func updateSelected(X: CGFloat, Y: CGFloat, XInterval:CGFloat, YInterval:CGFloat)
    {
       
        var rowRes:CGFloat = Y/YInterval
        var colRes:CGFloat = X/XInterval
        _column = Int(colRes)
        
        if(rowRes < 1)
        {
            _row = "a"
        }
        else if(rowRes >= 1 && rowRes < 2)
        {
            _row = "b"
        }
        else if (rowRes >= 2 && rowRes < 3)
        {
            _row = "c"
        }
        else if (rowRes >= 3 && rowRes < 4)
        {
            _row = "d"
        }
        else if (rowRes >= 4 && rowRes < 5)
        {
            _row = "e"
        }
        else if (rowRes >= 5 && rowRes < 6)
        {
            _row = "f"
        }
        
        else if(rowRes >= 6 && rowRes < 7)
        {
            _row = "g"
        }
        else if (rowRes >= 7 && rowRes < 8)
        {
            _row = "h"
        }
        else if(rowRes >= 8 && rowRes < 8.95)
        {
            _row = "i"
        }
        else
        {
            _row = "j"
        }
    
        //invoke delegate, tell delegate to attempt to update the model
        delegate?.getRowAndColumn(_row, column: _column)
        
        
    
    }
    

   
    

}
