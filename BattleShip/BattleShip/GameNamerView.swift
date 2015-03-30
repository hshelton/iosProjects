//
//  SplashView.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

protocol GameChosenResponder: class
{
    func signalCreateGame(gameName: String, playerName: String)
}


class GameNamerView: UIView
{
   
    weak var delegate: GameChosenResponder? = nil
    
    
    override init (frame: CGRect)
    {
        super.init(frame:frame)
        
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
        /*
        var r: CGRect = bounds
        _texture.frame = bounds
        var pad: CGRect = CGRectZero
        var container: CGRect = CGRectZero
        (pad, r) = r.rectsByDividing(64, fromEdge: CGRectEdge.MinYEdge)
        (_artView.frame, r) = r.rectsByDividing(r.height/1.2, fromEdge: CGRectEdge.MinYEdge)
        
        (_newGame.frame, _listGames.frame) = r.rectsByDividing(r.width/2, fromEdge: CGRectEdge.MinXEdge)
        _titleLabel.frame = CGRect(x: 0, y: _artView.frame.midY - 40, width: bounds.width, height: 40)

        */
        
        
    }
    
    func newGamePressed()
    {
   
        
    }
    
    func listGamesPressed()
    {
     
    }
    
    
    
    
    
}
