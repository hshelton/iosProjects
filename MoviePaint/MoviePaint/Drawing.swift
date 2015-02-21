//
//  Drawing.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import Foundation

/*
* A drawing can be modeled as an array of polylines
*/
class Drawing
{
    /* internals section */
    var _lineArray : [Polyline] = []
    
    struct PointF
    {
        var x: Float
        var y: Float
    }
    struct Color
    {
        var r: Float
        var g: Float
        var b: Float
        var a: Float
    }
    struct Polyline
    {
        var points: [PointF]
        var color: Color
    }
    /* */
    
    /* public section */
    
    var polylineCount: Int {return _lineArray.count}
    
    
    func polylineAtIndex(polylineIndex: Int) -> Polyline
    {
        return _lineArray[polylineIndex]
    }
    
    func appendPolyline(polyline: Polyline)
    {
        _lineArray.append(polyline)
    }
    
    
    func getNewModelAsPercentageofSelf(percentage: Float) -> Drawing
    {
        var temp: Drawing = Drawing()
        
        var pointCount: Int = 0
        for polyLine in _lineArray
        {
          pointCount+=polyLine.points.count
        }
        
        var desiredCount: Int = Int(Float(pointCount) * percentage)
        
        var newCount:Int = 0
        
      
            for polyLine in _lineArray
            {
                //add the whole polyline
                if (newCount + polyLine.points.count <= desiredCount)
                {
                    temp.appendPolyline(polyLine)
                    newCount+=polyLine.points.count
                }
                else
                {
                    var toAdd: Polyline = Polyline(points: [], color: polyLine.color)
                    //add in the points
                
                     for(var pointIndex: Int = 0; pointIndex < polyLine.points.count; pointIndex++)
                     {
                        //stop adding when we have enough
                        if(newCount == desiredCount)
                        {
                            break
                        }
                        toAdd.points.append(polyLine.points[pointIndex])
                        newCount++
                        
                    }
                    temp.appendPolyline(toAdd)
                    break //jump out of outer loop
                }
            }
        
        return temp
    }
    /*
    * Save drawing to file using plist format
    *
    func writeToFile(path:String)
    {
        var drawingArray: NSMutableArray = []
        
        //TODO: Build up object graph
        for Polyline in _lineArray
        {
            let polyLineColor: NSDictionary = [
                
                "r": Polyline.color.r,
                "g": Polyline.color.g,
                "b": Polyline.color.b,
                "a": Polyline.color.a]
            
            var polyLinePoints: NSMutableArray = []
            
            for point in Polyline.points
            {
                let pointDictionary: NSDictionary = ["x": point.x, "y": point.y]
    TODO: Finish the rest of this function
            }
            
            let dictionary: NSDictionary = ["points": Polyline.points, "color": Polyline.color]
            drawingArray.addObject(dictionary)
            
        }
        
        drawingArray.writeToFile(path, atomically: true)
        
    }
*/
    /* */
}