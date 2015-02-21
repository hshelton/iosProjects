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
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }

    
    
    

}

