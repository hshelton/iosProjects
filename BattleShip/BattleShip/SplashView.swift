//
//  SplashView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

protocol AppStateUpdateResponder: class
{
    func AppStateChanged(reason: String)
}


class SplashView: UIView
{
    private var _newGame: UIButton! = nil
    private var _listGames: UIButton! = nil
    private var _myGames: UIButton! = nil
    private var _artView: UIView! = nil
    private var _texture: UIView! = nil
    private var _titleLabel: UILabel! = nil
    weak var delegate: AppStateUpdateResponder?
    
    override init (frame: CGRect)
    {
        super.init(frame:frame)
        
        _texture = UIView()
        _texture.backgroundColor = UIColor(patternImage: UIImage(named:"earth.jpg")!)
        addSubview(_texture)
        //set up ui components and add them as subviews
        _artView = UIView(frame: frame)
        _artView.backgroundColor = UIColor(red: 0.07, green: 0.4, blue: 0.75, alpha: 0.94)
        addSubview(_artView)
        
        _newGame = UIButton()
        _newGame.backgroundColor = UIColor(red: 0, green:0.85, blue:0.3, alpha: 1.0)
        _newGame.setTitle("New Game", forState: UIControlState.Normal)
        _newGame.addTarget(self, action: "newGamePressed", forControlEvents: UIControlEvents.TouchDown)
        addSubview(_newGame)
        
        _listGames = UIButton()
        _listGames.backgroundColor = UIColor.darkGrayColor()
        _listGames.setTitle("List Games", forState: UIControlState.Normal)
        _listGames.addTarget(self, action: "listGamesPressed", forControlEvents: UIControlEvents.TouchDown)
        addSubview(_listGames)
        
        _titleLabel = UILabel()
        _titleLabel.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        _titleLabel.text = "Battleship"; _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor.whiteColor(); _titleLabel.font = UIFont.boldSystemFontOfSize(40.0)
        addSubview(_titleLabel)
        
        _myGames = UIButton()
        _myGames.backgroundColor = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        _myGames.setTitle("MyGames", forState: UIControlState.Normal)
        _myGames.addTarget(self, action: "myGamesPressed", forControlEvents: UIControlEvents.TouchDown)
        addSubview(_myGames)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init ()
    {
        super.init()
    }
    
    func renameButton(buttonText: String)
    {
        _newGame.setTitle(buttonText, forState: UIControlState.Normal)
    }
   override func layoutSubviews()
   {
    var r: CGRect = bounds
    _texture.frame = bounds
    var pad: CGRect = CGRectZero
    var container: CGRect = CGRectZero
    (pad, r) = r.rectsByDividing(64, fromEdge: CGRectEdge.MinYEdge)
    (_artView.frame, r) = r.rectsByDividing(r.height/1.2, fromEdge: CGRectEdge.MinYEdge)
   
    (_newGame.frame, _listGames.frame) = r.rectsByDividing(r.width/2, fromEdge: CGRectEdge.MinXEdge)
    _titleLabel.frame = CGRect(x: 0, y: _artView.frame.midY - 40, width: bounds.width, height: 40)
    
    _myGames.frame = CGRect(x: 0, y: 64, width: bounds.width, height: 50)
    }
    
    func newGamePressed()
    {
        //notify those interested that the application state has changed
        if(_newGame.titleForState(UIControlState.Normal) == "New Game")
        {
                    delegate?.AppStateChanged("new")
            
        }
        else
        {
            delegate?.AppStateChanged("newP2")
        }

    }
    
    func listGamesPressed()
    {
        //notify those interested that the application state has changed
        delegate?.AppStateChanged("list")
    }
    
    func myGamesPressed()
    {
        delegate?.AppStateChanged("myGames")
    }
    
    
    
    
}
