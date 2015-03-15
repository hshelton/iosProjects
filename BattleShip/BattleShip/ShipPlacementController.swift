//
//  ShipPlacementController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/7/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit

//View controller used to control ship placement for player 1 and player 2
class ShipPlacementController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, GridViewRegistrant
{
    var _placementGrid: GridView = GridView()
    private var _shipTypeSelector: UIPickerView = UIPickerView()
    private var _underlyingView: UIView = UIView()
    private var _pickerData = [["Vertical", "Horizontal"],["Carrier", "Battleship", "Submarine", "Destroyer", "Patrol"]]

    //logic to make sure that each ship is only placed once
    private var _carrierPlaced: Bool = false
    private var _battleshipPlaced: Bool = false
    private var _submaringePlaced: Bool = false
    private var _destroyerPlaced: Bool = false
    private var _patrolPlaced: Bool = false
    
    
    var _shipGrid: ShipGrid = ShipGrid() //keeps track of the ships that have been placed. later will be passed to the main controller
    private var sType: Ship = Carrier()
    private var horizontalInsert: Bool = false
    
    weak var delegate: AppStateUpdateResponder?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    override func loadView()
    {
        
        _shipTypeSelector.frame = CGRect(x: 0, y: 384, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 360)
        
        _placementGrid.frame = CGRect(x:0, y:64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - _shipTypeSelector.bounds.height)
        
        _shipTypeSelector.dataSource = self
        _shipTypeSelector.delegate = self
        _shipTypeSelector.backgroundColor = UIColor.whiteColor()
        _underlyingView.backgroundColor = UIColor.blackColor()
        _underlyingView.addSubview(_shipTypeSelector)
        
        _underlyingView.addSubview(_placementGrid)
        _placementGrid.delegate = self
        view = _underlyingView
        
        
        self.title = "Place Ships"
    }
    
   
    func getRowAndColumn (row: Character, column: Int)
    {
        //try to place the ship into the model
        let valid: Bool = _shipGrid.InsertShip(sType, row: row, col: column, horizontal: horizontalInsert)
        if(valid)
        {
            // tell view to color in the rest of the view
            _placementGrid.updateRectsToDraw(sType._size, horizontal: horizontalInsert)
            
            //disable placement of duplicate
            switch(sType._type)
            {
            case "Carrier":
                _carrierPlaced = true
            case "Battleship":
                _battleshipPlaced = true
            case "Submarine":
                _submaringePlaced = true
            case "Destroyer":
                _destroyerPlaced = true
            case "Patrol":
                _patrolPlaced = true
                
            default:
                return
            }
            recalculatePickerData()
            
        }
    
    }
    
  
    func numberOfComponentsInPickerView(pickerView: UIPickerView) ->Int
    {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(component == 0)
        {
            return 2
        }
        else
        {
            return _pickerData[1].count
        }
        
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
       
        
        return _pickerData[component][row]
    }

    //ship placement outcome will depend on the ship type selected and its orientation
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var chosen = _pickerData[component][row]
       
        //TODO: Each ship type should only be selectable one time
        

        switch chosen
        {
            case "Vertical":
                horizontalInsert = false
            case "Horizontal":
                horizontalInsert = true
       
            
            default:
                recalculatePickerData()
            
        }
        
        
    }
    
    //eliminate options from the picker view as ship types are placed
    func recalculatePickerData()
    {
        var newData: [String] = []
        if(!_carrierPlaced && !_battleshipPlaced && !_destroyerPlaced && !_submaringePlaced && !_patrolPlaced)
        {
            _shipTypeSelector.selectRow(0, inComponent: 1, animated: true)
            sType = Carrier()
            return
        }
        
        if(_carrierPlaced)
        {
            _shipTypeSelector.selectRow(1, inComponent: 1, animated: false)
            sType = BattleShip()
        }
        if(_battleshipPlaced)
        {
            _shipTypeSelector.selectRow(2, inComponent: 1, animated: false)
            sType = Submarine()
        }
        if(_submaringePlaced)
        {
            _shipTypeSelector.selectRow(3, inComponent: 1, animated: false)
            sType = Destroyer()
        }
        if(_destroyerPlaced)
        {
            _shipTypeSelector.selectRow(4, inComponent: 1, animated: false)
            sType = Patrol()
        }
        if(_patrolPlaced)
        {
           
           delegate?.AppStateChanged("placed")
        }
     
    }
}
