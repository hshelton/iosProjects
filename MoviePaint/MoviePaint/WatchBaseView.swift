//
//  WatchBaseView.swift
//  MoviePaint
//
//  Created by u0658884 on 2/20/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit


/*
* A watch base view has a drawing rectangle (type WatchView), a play button, a pause button, and a scrubber
*/
class WatchBaseView: UIView {
    
    
    
    private var _scrubber: UISlider! = nil
    private var _play: UIButton! = nil
    private var _pause: UIButton! = nil
    private var _watch: WatchView! = nil
    
    private var _playPercent: Float = 1
    
    private var _padView: UIView! = nil
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        _watch = WatchView(frame: frame)
        _watch.backgroundColor = UIColor.whiteColor()
        addSubview(_watch)
        
        
        
        _scrubber = UISlider(frame: frame)
        addSubview(_scrubber)
        
        
        _play = UIButton()
        _play.backgroundColor = UIColor.greenColor()
        _play.setTitle("Play", forState: UIControlState.Normal)
        addSubview(_play)
        
       _pause = UIButton()
        _pause.backgroundColor = UIColor.lightGrayColor()
        _pause.setTitle("Pause", forState: UIControlState.Normal)
        addSubview(_pause)

        
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
    
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        var pad: CGRect = CGRectZero
        var container: CGRect = CGRectZero
        
        (pad, r) = r.rectsByDividing(r.height/8, fromEdge: CGRectEdge.MinYEdge)
        (_watch.frame, r) = r.rectsByDividing(r.height/1.4, fromEdge: CGRectEdge.MinYEdge)
      
        (_scrubber.frame, r) = r.rectsByDividing(r.height/2, fromEdge: CGRectEdge.MinYEdge)
        (container, r) = r.rectsByDividing(r.height/1.1, fromEdge: CGRectEdge.MinYEdge)
        (_play.frame, _pause.frame) = container.rectsByDividing(container.width/2, fromEdge: CGRectEdge.MinXEdge)
        
        
       
        
        
    }

}
