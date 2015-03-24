//
//  TransitionView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/21/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

class TransitionView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var ok: UIButton = UIButton()
    weak var delegate: AppStateUpdateResponder? = nil
    
    override init (frame: CGRect)
    {
        super.init(frame: frame)
       
        
        let Button = UIButton()
        
     
        Button.setTitle("Ready", forState: .Normal)
        Button.frame = CGRectMake(0, UIScreen.mainScreen().bounds.midY - 100, UIScreen.mainScreen().bounds.width, 200)
        Button.backgroundColor = UIColor.darkGrayColor()
        Button.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
      
        addSubview(Button)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

        // Do any additional setup after loading the view, typically from a nib.
    
    
    func pressed(sender: UIButton!) {
     delegate?.AppStateChanged("ready")
    }
    
    override init()
    {
        super.init()
    }
}
