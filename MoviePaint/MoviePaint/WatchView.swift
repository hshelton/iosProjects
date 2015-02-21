//
//  watchView.swift
//  MoviePaint
//
//  Created by u0658884 on 2/20/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class WatchView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    private var _model: Drawing?

    
    private var _modelSet: Bool = false
    override init(frame: CGRect)
     {
        super.init(frame: frame)
        
        var screenWidth = UIScreen.mainScreen().bounds.width
        var screenBottom = UIScreen.mainScreen().bounds.maxY
        
       

        
    }

    override init()
    {
        super.init()
        
    }
    
    func setModel(model: Drawing)
    {
        _model = model
        _modelSet = true
        setNeedsDisplay()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }

    
    //draws the entire model over a ten second interval
    override  func drawRect(rect: CGRect) {
        
    
        if(!_modelSet)
        {
            return
        }
        let context: CGContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 10.0)
        
        CGContextSetLineCap(context, CGLineCap(1))
        
        for coloredPolyline in _model!._lineArray
        {
            var currentColor: CGColor = UIColor(red: CGFloat(coloredPolyline.color.r), green: CGFloat(coloredPolyline.color.g), blue: CGFloat(coloredPolyline.color.b), alpha: CGFloat(coloredPolyline.color.a)).CGColor
            
            CGContextSetStrokeColorWithColor(context, currentColor)
            
            
            for(var pointIndex: Int = 0; pointIndex < coloredPolyline.points.count; pointIndex++)
            {
                //let point: CGPoint = _points[pointIndex]
                let point: CGPoint = CGPoint(x: CGFloat(coloredPolyline.points[pointIndex].x) * bounds.width, y: CGFloat(coloredPolyline.points[pointIndex].y) * bounds.height)
                
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






