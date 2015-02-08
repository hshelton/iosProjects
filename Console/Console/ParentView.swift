//
//  ParentView.swift
//  Console
//
//  Created by u0658884 on 2/7/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class Console: UIView

{
    private var _colorKnob: ColorKnob
    private var _alpha: UIView
    private var _saturation: UIView
    private var _hue: UIView
    
    override init(frame: CGRect)
    {
        _colorKnob = ColorKnob(frame: frame) //window can't be null for this to work
        _colorKnob.backgroundColor = UIColor.darkGrayColor()
        addSubview(_colorKnob)
        
        
        
    }
    
    
    override func layoutSubViews()
    {
        
        
    }
}



        