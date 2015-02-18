//
//  SubviewManager.swift
//  RGBColorChooser
//
//  Created by u0658884 on 2/9/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

protocol colorDelegate: class
{
    func chooserSubviewManager(SubviewManagerInstance: ChooserSubviewManager, colorSelected: UIColor)
}


class ChooserSubviewManager : UIView, ValueSliderDelegate
{
    private var _redSlider : ValueSlider! = nil
    private var _blueSlider : ValueSlider! = nil
    private var _greenSlider: ValueSlider! = nil
    private var _alphaSlider: ValueSlider! = nil
    private var _restrictedView: UIView! = nil
    private var _padView: UIView! = nil
    
    private var bg : UIColor = UIColor.whiteColor()
    private var _previousView: UIView! = nil
    private var _currentView: UIView! = nil
    private var _redValue: CGFloat = 0.0
    private var _greenValue: CGFloat = 0.0
    private var _blueValue: CGFloat = 0.0
    var _alphaValue: CGFloat = 0.0
    
    private var _UIRGBCOLOR: UIColor! = nil

    weak var delegate: colorDelegate? = nil
    


    override init()
    {
        super.init()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    
        _redSlider = ValueSlider(frame: frame)
        _redSlider.setName("red")
        _redSlider.backgroundColor = bg
        _redSlider.thumbColor = UIColor.redColor().CGColor
        _redSlider.delegate = self
        addSubview(_redSlider)
        
        _blueSlider = ValueSlider(frame: frame)
        _blueSlider.setName("blue")
        _blueSlider.backgroundColor = bg
        _blueSlider.thumbColor = UIColor.blueColor().CGColor
         _blueSlider.delegate = self
        addSubview(_blueSlider)
        
        _greenSlider = ValueSlider(frame: frame)
        _greenSlider.setName("green")
        _greenSlider.backgroundColor = bg
        _greenSlider.thumbColor = UIColor.greenColor().CGColor
         _greenSlider.delegate = self
        addSubview(_greenSlider)
        
        _alphaSlider = ValueSlider(frame: frame)
        
        _alphaSlider.setName("alpha")
        _alphaSlider.backgroundColor = bg
        _alphaSlider.thumbColor = UIColor.blackColor().CGColor
         _alphaSlider.delegate = self
       
        addSubview(_alphaSlider)
       
        
        _restrictedView = UIView(frame: frame)
        _restrictedView.backgroundColor = UIColor(patternImage: UIImage(named:"checkerboard.png")!)
        addSubview(_restrictedView)
        
        _padView = UIView(frame: frame)
        _padView.backgroundColor = UIColor.whiteColor()
        addSubview(_padView)
       // _alphaSlider.moveToMax()
          _UIRGBCOLOR = UIColor(red: _redValue, green:  _greenValue, blue: _blueValue, alpha: _alphaValue)
       // _currentView.backgroundColor = _UIRGBCOLOR

        _currentView = UIView(frame: _restrictedView.frame)
        _restrictedView.addSubview(_currentView)
        
        
        setNeedsDisplay()
    }
    
   override func layoutSubviews() {
        var r: CGRect = bounds
    
    
    (_padView.frame, r) = r.rectsByDividing(r.height/7, fromEdge: CGRectEdge.MinYEdge)
    (_alphaSlider.frame, r) = r.rectsByDividing(r.height/6, fromEdge: CGRectEdge.MinYEdge)
    (_redSlider.frame, r) = r.rectsByDividing(r.height/5, fromEdge: CGRectEdge.MinYEdge)
    (_greenSlider.frame, r) = r.rectsByDividing(r.height/4, fromEdge: CGRectEdge.MinYEdge)
    (_blueSlider.frame, r) = r.rectsByDividing(r.height/3, fromEdge: CGRectEdge.MinYEdge)

    
    (_restrictedView.frame, r) = r.rectsByDividing(r.height, fromEdge: CGRectEdge.MinYEdge)
    _currentView.frame = _restrictedView.frame

    

    }
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }
    

    
    
   func valueChanged(slider: ValueSlider, value: Int)
   {
   
        if(slider.getName() == "red")
        {
            _redValue = CGFloat(value) / 255
        }
        if(slider.getName() == "green")
        {
        _greenValue = CGFloat(value) / 255
        }
        if(slider.getName() == "blue")
        {
        _blueValue = CGFloat(value) / 255
        }
    
        if(slider.getName() == "alpha")
        {
        _alphaValue = CGFloat(value) / 255
        }
    
    _UIRGBCOLOR = UIColor(red: _redValue, green:  _greenValue, blue: _blueValue, alpha: _alphaValue)
   
    _currentView.backgroundColor = _UIRGBCOLOR
    
    addSubview(_currentView)
    
    //update those who are interested that we've chosen a new color
    delegate?.chooserSubviewManager(self, colorSelected: _UIRGBCOLOR)
  //  setNeedsDisplay()
    
    }
    
}
