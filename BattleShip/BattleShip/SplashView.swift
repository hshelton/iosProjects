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
    private var _artView: UIView! = nil
    weak var delegate: AppStateUpdateResponder?
    
    override init (frame: CGRect)
    {
        super.init(frame:frame)
        
        //set up ui components and add them as subviews
        _artView = UIView(frame: frame)
        _artView.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.85, alpha: 1.0)
        addSubview(_artView)
        
        _newGame = UIButton()
        _newGame.backgroundColor = UIColor(red: 0, green:0.85, blue:0.5, alpha: 1.0)
        _newGame.setTitle("New Game", forState: UIControlState.Normal)
        _newGame.addTarget(self, action: "newGamePressed", forControlEvents: UIControlEvents.TouchDown)
        addSubview(_newGame)
        
        _listGames = UIButton()
        _listGames.backgroundColor = UIColor.darkGrayColor()
        _listGames.setTitle("List Games", forState: UIControlState.Normal)
        _listGames.addTarget(self, action: "listGamesPressed", forControlEvents: UIControlEvents.TouchDown)
        addSubview(_listGames)
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
    var r: CGRect = bounds
    var pad: CGRect = CGRectZero
    var container: CGRect = CGRectZero
    (pad, r) = r.rectsByDividing(64, fromEdge: CGRectEdge.MinYEdge)
    (_artView.frame, r) = r.rectsByDividing(r.height/1.2, fromEdge: CGRectEdge.MinYEdge)
   
    (_newGame.frame, _listGames.frame) = r.rectsByDividing(r.width/2, fromEdge: CGRectEdge.MinXEdge)
    
    }
    
    
    
    func newGamePressed()
    {
        //notify those interested that the application state has changed
        delegate?.AppStateChanged("new")
    }
    
    func listGamesPressed()
    {
        //notify those interested that the application state has changed
        delegate?.AppStateChanged("list")
    }
    
    
    
    
    
}
