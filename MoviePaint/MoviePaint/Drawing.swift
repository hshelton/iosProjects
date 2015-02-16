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
    private var _lineArray : [Polyline] = []
    
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
    
    
    /* */
}