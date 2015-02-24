//
//  WatchBaseView.swift
//  MoviePaint
//
//  Created by u0658884 on 2/20/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

protocol DrawingResponder: class
{
    func reqestAllPoints () -> Drawing
    func requestSomePoints(percent:Float) -> Drawing
    func timerChanged(delta: NSTimeInterval)
    
}

/*
* A watch base view has a drawing rectangle (type WatchView), a play button, a pause button, and a scrubber
*/
class WatchBaseView: UIView {
    
    
    
    private var _scrubber: UISlider! = nil
    private var _play: UIButton! = nil
    private var _pause: UIButton! = nil
    private var _watch: WatchView! = nil
    private var _timer: NSTimer! = nil
    
    private var _playPercent: Float = 1
    private var _intervalsElapsed: Int = 0
    private var _padView: UIView! = nil
    private var _paused: Bool = false
    weak var delegate: DrawingResponder?
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        _watch = WatchView(frame: frame)
        _watch.backgroundColor = UIColor.whiteColor()
        addSubview(_watch)
        
        
        
        _scrubber = UISlider(frame: frame)
        _scrubber.maximumValue = 1
        _scrubber.minimumValue = 0
        addSubview(_scrubber)
        _scrubber.addTarget(self, action: "scrub", forControlEvents: UIControlEvents.ValueChanged)
        
        _play = UIButton()
        _play.backgroundColor = UIColor.greenColor()
        
        _play.setTitle("Play", forState: UIControlState.Normal)
        _play.addTarget(self, action: "initializeTimer", forControlEvents: UIControlEvents.AllTouchEvents)
            
            addSubview(_play)
        
       _pause = UIButton()
        _pause.backgroundColor = UIColor.lightGrayColor()
        _pause.setTitle("Pause", forState: UIControlState.Normal)
        _pause.addTarget(self, action:"pause", forControlEvents: UIControlEvents.TouchDown)
        addSubview(_pause)

        
        
    }
    
    override init()
    {
        super.init()
        
    }
    
    func initializeTimer()
    {
         _intervalsElapsed = 0
        if(_timer != nil)
        {
            _timer.invalidate()
        }
        if(_paused)
        {
            _paused = false
        }
        
        if(_play.titleLabel?.text == "Play")
        {
            _play.setTitle("Restart", forState: UIControlState.Normal)
        }
        
        
        _timer = NSTimer(timeInterval: 0.1, target: self, selector:"timerFunc", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(_timer, forMode: NSRunLoopCommonModes)
       
    
    }
    
    func timerFunc ()
    {
        if(_paused)
        {
            _pause.setTitle("Continue", forState: UIControlState.Normal)
            return
        }
        else
        {
            _pause.setTitle("Pause", forState: UIControlState.Normal)
        }
       _intervalsElapsed++
        let amt: Float = Float(Float(_intervalsElapsed)/100)
        
    
        if(amt <= 1)
        {
        _scrubber.value = amt
        _scrubber.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
        
    }
    
    func scrub()
    {
        var amt = _scrubber.value
        var drawing: Drawing = delegate!.requestSomePoints(amt)
        drawFromModel(drawing)
    }
    //toggle paused property
    func pause()
    {
        _paused = !_paused
        if(_paused && _intervalsElapsed >= 100)
        {
            _intervalsElapsed = 0
        }
    }
    
   /* func drawAll()
    {
        var drawing: Drawing = delegate!.reqestAllPoints()
        drawFromModel(drawing)
    }
  */
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }
    
    
    override func layoutSubviews() {
        var r: CGRect = bounds
        var pad: CGRect = CGRectZero
        var container: CGRect = CGRectZero
        
        (pad, r) = r.rectsByDividing(r.height/9, fromEdge: CGRectEdge.MinYEdge)
        (_watch.frame, r) = r.rectsByDividing(r.height/1.4, fromEdge: CGRectEdge.MinYEdge)
      
        (_scrubber.frame, r) = r.rectsByDividing(r.height/2, fromEdge: CGRectEdge.MinYEdge)
        (container, r) = r.rectsByDividing(r.height/1.1, fromEdge: CGRectEdge.MinYEdge)
        (_play.frame, _pause.frame) = container.rectsByDividing(container.width/2, fromEdge: CGRectEdge.MinXEdge)

        
    }
    //supplies a drawing model to the watch view
    func drawFromModel(model: Drawing)
    {
        _watch.setModel(model)
        
    }
}
