//
//  SplashView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit



class GameNamerView: UIView
{
   
    weak var delegate: GameChosenResponder? = nil
    var gameNameInput: UITextField = UITextField()
    var playerNameInput: UITextField = UITextField()
    var gameNameLabel: UILabel = UILabel()
    var playerNameLabel: UILabel = UILabel()

    
    override init (frame: CGRect)
    {
        super.init(frame:frame)
        gameNameInput.backgroundColor = UIColor.whiteColor()
        playerNameInput.backgroundColor = UIColor.whiteColor()
        
        gameNameLabel.text = "Game: "
        playerNameLabel.text = "Player: "
        playerNameLabel.font = UIFont(name: playerNameLabel.font.fontName, size: 14)
        gameNameLabel.font = UIFont(name: playerNameLabel.font.fontName, size: 14)
        
      
 
        addSubview(gameNameLabel)
        addSubview(playerNameLabel)
        addSubview(gameNameInput)
        addSubview(playerNameInput)
        backgroundColor = UIColor.lightGrayColor()
        
        let Button = UIButton()
            
        Button.setTitle("Ready", forState: .Normal)
        Button.frame = CGRectMake(100, UIScreen.mainScreen().bounds.midY + 40, UIScreen.mainScreen().bounds.width - 110, 50)
        Button.backgroundColor = UIColor(red: 0, green:0.85, blue:0.3, alpha: 1.0)
        Button.addTarget(self, action: "pressed", forControlEvents: .TouchUpInside)
        
        addSubview(Button)
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
       gameNameInput.frame = (CGRect(x: 100, y: bounds.midY-40, width: bounds.width - 110, height: 30))
       playerNameInput.frame = (CGRect(x: 100, y: bounds.midY, width: bounds.width - 110, height: 30))
       playerNameLabel.frame = CGRect(x: 10, y: bounds.midY, width: 50, height: 40)
       gameNameLabel.frame = CGRect(x: 10, y: bounds.midY-40, width: 50, height: 40)
        
    }
    
    func pressed()
    {
        var gameName:String = gameNameInput.text
        var playerName:String = playerNameInput.text
        
        if(gameName.utf16Count < 2 || playerName.utf16Count < 2 )
        {
            var summaryAlert = UIAlertView(title: "oops", message: "Game name and player name must be two or more characters each", delegate: nil, cancelButtonTitle: "Close", otherButtonTitles: "OK")
            summaryAlert.show()
            return
        }
        //invoke delegate to create a new game
        delegate?.signalCreateGame(gameName, playerName: playerName)
        
    }
    
  
    
    
    
    
    
}
