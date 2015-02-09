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
    private var _colorChosen: UIView! = nil
    private var _previousColor: UIView! = nil
    private var _brightness : UIView! = nil
    
    
    var red :CGFloat = CGFloat(0.0)
    var green: CGFloat = CGFloat(0.0)
    var blue: CGFloat = CGFloat(0.0)
    
    weak var delegate: ParentViewDelegate? = nil
  
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        _colorKnob = ColorKnob(frame: frame) //window can't be null for this to work
        
        addSubview(_colorKnob)
        
        
        
        _alpha = UIView(frame: frame)
        _alpha.backgroundColor = UIColor.blueColor()
        addSubview(_alpha)
        var alphaLabel: UILabel = UILabel(frame: CGRectMake(16.0, 16.0, _alpha.frame.width, 16.0)); alphaLabel.text = "Alpha"
        _alpha.addSubview(alphaLabel)
        
        
        _saturation = UIView(frame: frame)
        _saturation.backgroundColor = UIColor.greenColor()
        var satLabel: UILabel = UILabel(frame: CGRectMake(16.0, 0.0, _saturation.frame.width, 16.0)); satLabel.text = "Saturation"
        _saturation.addSubview(satLabel)
        addSubview(_saturation)
        
        _hue = UIView(frame: frame)
        _hue.backgroundColor = UIColor.yellowColor()
        var hueLabel: UILabel = UILabel(frame: CGRectMake(16.0, 0.0, _hue.frame.width, 16.0)); hueLabel.text = "Hue"
        _hue.addSubview(hueLabel)
        addSubview(_hue)
        
        _colorChosen = UIView(frame: frame)
        _colorChosen.backgroundColor = UIColor.brownColor()
        addSubview(_colorChosen)

        var currentLabel: UILabel = UILabel(frame: CGRectMake(16.0, 0.0, _colorChosen.frame.width, 16.0)); currentLabel.text = "Current Color"
        _colorChosen.addSubview(currentLabel)
        
        _previousColor = UIView(frame: frame)
        _previousColor.backgroundColor = UIColor.whiteColor()
        var prevLabel: UILabel = UILabel(frame: CGRectMake(16.0, 0.0, _previousColor.frame.width, 16.0)); prevLabel.text = "Previous Color"
        _previousColor.addSubview(prevLabel)
        
 
        addSubview (_previousColor)
        
        _brightness = UIView(frame: frame)
        _brightness.backgroundColor = UIColor.purpleColor()
        var brightLabel: UILabel = UILabel(frame: CGRectMake(16.0, 0.0, _brightness.frame.width, 16.0)); brightLabel.text = "Brightness"
        _brightness.addSubview(brightLabel)
         addSubview (_brightness)
        
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
        var r2 :CGRect = bounds
        
        
        //(_colorKnob.frame, r) = r.rectsByDividing(r.height * 0.6, fromEdge: CGRectEdge.MinYEdge)
       // (_alpha.frame, r) = r.rectsByDividing(r.height * 0.333, fromEdge: CGRectEdge.MinYEdge)
        //(_saturation.frame, _hue.frame) = r.rectsByDividing(r.height * 0.5, fromEdge: CGRectEdge.MinYEdge)
        
        (_colorKnob.frame, _colorChosen.frame) = r.rectsByDividing(r.height * 0.7, fromEdge: CGRectEdge.MinYEdge)
        (_previousColor.frame, _colorChosen.frame) = _colorChosen.frame.rectsByDividing(_colorChosen.frame.width * 0.5, fromEdge: CGRectEdge.MinXEdge)
        (_colorKnob.frame, _alpha.frame) = _colorKnob.frame.rectsByDividing(_colorKnob.frame.width * 0.5, fromEdge: CGRectEdge.MinXEdge)
        (_alpha.frame, _saturation.frame) = _alpha.frame.rectsByDividing(_alpha.frame.height * 0.25, fromEdge: CGRectEdge.MinYEdge)
        (_saturation.frame, _hue.frame) = _saturation.frame.rectsByDividing(_saturation.frame.height * 0.333, fromEdge: CGRectEdge.MinYEdge)
        (_hue.frame, _brightness.frame) = _hue.frame.rectsByDividing(_hue.frame.height * 0.5, fromEdge: CGRectEdge.MinYEdge)
        
        //(_colorKnob.frame, _previousColor.frame) = _colorKnob.frame.rectsByDividing(_colorKnob.frame.height * 0.7, fromEdge: CGRectEdge.MinYEdge)
        
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



        