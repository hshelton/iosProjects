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
    
    /*
    * A Polyline is a set of points and a line color
    *
    */
    struct Polyline
    {
        var points: [PointF]
        var color: Color
    }
    
    var polylineCount: Int {return 3}
    
    func polylineAtIndex(polylineIndex: Int) -> Polyline
    {
        return Polyline(points: [PointF(x:0.0, y:0.0), PointF(x:1.1, y: 8.6)], color: Color(r: 1.0, g: 1.0, b: 1.0, a: 1.0))
    }
}