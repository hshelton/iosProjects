//
//  CustomSlider.swift
//  Console
//
//  Created by u0658884 on 2/8/15.
//  Copyright (c) 2015 u0658884. All rights reserved.

// some code referenced from a tutorial:
// http://www.raywenderlich.com/76433/how-to-make-a-custom-control-swift
//

import UIKit
import QuartzCore

class CustomSlider: UIControl {

   var minVal = 0.0
   var maxVal = 100.0

   let trackLayer = CALayer()
   let thumbLayer = CALayer()
    
    var thumbWidth: CGFloat
    {
        return CGFloat(bounds.height)
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = UIColor.greenColor().CGColor
        layer.addSublayer(trackLayer)
        
        thumbLayer.backgroundColor = UIColor.
        
    }
    
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }
    
}
