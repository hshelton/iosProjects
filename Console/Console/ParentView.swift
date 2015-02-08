//
//  ParentView.swift
//  Console
//
//  Created by u0658884 on 2/7/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

protocol ParentViewDelegate: class
{
    
    func parentView(parentView: ParentView, redvalueselected redVal: CGFloat, greenvalueselected greenVal: CGFloat, bluevalueselected blueVal: CGFloat)
    
    
}

class ParentView: UIView, ColorKnobDelegate

{
    private var _colorKnob: ColorKnob! = nil
    private var _alpha: UIView! = nil
    private var _saturation: UIView! = nil
    private var _hue: UIView! = nil
    
    var red :CGFloat = CGFloat(0.0)
    var green: CGFloat = CGFloat(0.0)
    var blue: CGFloat = CGFloat(0.0)
    
    weak var delegate: ParentViewDelegate? = nil
  
    
    override init(frame: CGRect)
    {
             super.init(frame: frame)
        _colorKnob = ColorKnob(frame: frame) //window can't be null for this to work
        _colorKnob.backgroundColor = UIColor.darkGrayColor()
        addSubview(_colorKnob)
        
        _alpha = UIView(frame: frame)
        _alpha.backgroundColor = UIColor.blueColor()
        addSubview(_alpha)
        
        _saturation = UIView(frame: frame)
        _saturation.backgroundColor = UIColor.greenColor()
        addSubview(_saturation)
        
        _hue = UIView(frame: frame)
        _hue.backgroundColor = UIColor.yellowColor()
        addSubview(_hue)
        
       _colorKnob.delegate = self
        
   

    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        assert(false, "Unsupported")
    }
    
    
    
    var alphaView:UIView {return _alpha}
    var saturationView:UIView {return _saturation}
    var hueView:UIView {return _hue}
    
    override func layoutSubviews()
    {
        var r :CGRect = bounds
        
        (_colorKnob.frame, r) = r.rectsByDividing(r.height * 0.6, fromEdge: CGRectEdge.MinYEdge)
        (_alpha.frame, r) = r.rectsByDividing(r.height * 0.333, fromEdge: CGRectEdge.MinYEdge)
        (_saturation.frame, _hue.frame) = r.rectsByDividing(r.height * 0.5, fromEdge: CGRectEdge.MinYEdge)
        
        
    }
    
    func colorKnob(colorKnob: ColorKnob, getRedValue value: CGFloat)
    {
        red = value
        invokeSelf()
        
    }
    func colorKnob(colorKnob: ColorKnob, getGreenValue value: CGFloat)
    {
        green = value
        invokeSelf()
    }
    func colorKnob(colorKnob: ColorKnob, getBlueValue value: CGFloat)
    {
        blue = value
        invokeSelf()
    }
    
    func invokeSelf()
    {
        delegate?.parentView(self, redvalueselected: red, greenvalueselected:green, bluevalueselected:blue)
    }

}



        