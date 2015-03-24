//
//  SplashView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit




class GamePlayView: UIView, GridViewRegistrant
{

    var _enemyLabel:UILabel! = nil
    var _opponentGrid:GridView! = nil
    var _youLabel: UILabel! = nil
    var _youGrid: GridView! = nil
    var _stats: UIView! = nil
    var _yourHP: UILabel! = nil
    var _enemyHP: UILabel! = nil
    var offGreen: UIColor = UIColor(red: 0, green:0.85, blue:0.3, alpha: 1.0)
    var greenText: UIColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
    weak var delegate: GridViewRegistrant?
    
    override init (frame: CGRect)
    {
        super.init(frame:frame)
        
        _enemyLabel = UILabel()
        _enemyLabel.text = "Enemy"; _enemyLabel.textAlignment = NSTextAlignment.Center
        _enemyLabel.textColor = UIColor.whiteColor()
        _enemyLabel.backgroundColor =  UIColor(red: 0.7, green: 0.15, blue: 0.15, alpha: 1.0)
        
        _youLabel = UILabel()
        _youLabel.text = "You"; _youLabel.textAlignment = NSTextAlignment.Center
        _youLabel.backgroundColor =  offGreen
        _youLabel.textColor = UIColor.whiteColor()
        
        _opponentGrid = GridView()
        _youGrid = GridView()
        _opponentGrid.delegate = self
        _youGrid.delegate = self
        
        _stats = UIView()
        _stats.backgroundColor = UIColor.blackColor()
        
        _yourHP = UILabel(); _yourHP.font = UIFont(name: "battle", size: 8.0)
        _yourHP.text = "You: 100%"; _yourHP.textAlignment = NSTextAlignment.Center
        _yourHP.textColor = greenText
        
        _enemyHP = UILabel(); _enemyHP.font = UIFont(name: "battle", size: 8.0)
        _enemyHP.text = "Enemy: 100%";  _enemyHP.textAlignment = NSTextAlignment.Center
        _enemyHP.textColor = greenText
        
        addSubview(_enemyLabel)
        addSubview(_opponentGrid)
        addSubview(_youLabel)
        addSubview(_youGrid)
        addSubview(_stats)
        addSubview(_yourHP)
        addSubview(_enemyHP)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init ()
    {
        super.init()
    }
    

    override func layoutSubviews()
    {
        _enemyLabel.frame = CGRect(x: 0, y: 64, width: bounds.width, height: 20)
     
        _opponentGrid.frame = CGRect(x: 0, y: 84, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height/1.8)
        
        _youLabel.frame = CGRect(x: 0, y: _opponentGrid.frame.maxY, width: bounds.width, height: 20)
        
        let Yremaining: CGFloat = bounds.height - _youLabel.frame.maxY
        _youGrid.frame = CGRect(x: bounds.width / 2, y: _youLabel.frame.maxY, width:bounds.width / 2, height: Yremaining)
        
        _stats.frame = CGRect(x: 0, y: _youGrid.frame.minY, width: Yremaining, height: Yremaining)
        _yourHP.frame = CGRect(x: 0, y: _stats.frame.minY, width: Yremaining, height: Yremaining / 2)
        _enemyHP.frame = CGRect(x: 0, y: _yourHP.frame.maxY, width: Yremaining, height: Yremaining / 2)
        
        
     
        setNeedsDisplay()
    }
    

   
    func getRowAndColumn (row: Character, column: Int)
    {
        //just pass this information up a level in inheritance
        delegate?.getRowAndColumn(row, column: column)
        
    }
    
    
}
