//
//  ViewController.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController, colorUpdate, ModelUpdater, DrawingResponder {
    
    //gives outside classes ability to mess with the paint view
    var paintView: PaintView {return view as PaintView}
    var chooser: ColorChooserController = ColorChooserController()
    var watch: WatchViewController = WatchViewController()
    var underlyingView = PaintView()
    var model: Drawing = Drawing()

    override func loadView()
    {
        view = underlyingView
        
        underlyingView.backgroundColor = UIColor.whiteColor()
        var colorButton : UIBarButtonItem = UIBarButtonItem(title: "Color", style: UIBarButtonItemStyle.Plain, target: self, action: "pushChooseView")
        var watchButton: UIBarButtonItem = UIBarButtonItem(title: "Watch", style:UIBarButtonItemStyle.Plain, target: self, action: "pushWatchView")
        chooser.getUpdate = self
        underlyingView.delegate = self
        underlyingView.strokeColor = UIColor.blackColor().CGColor
        self.navigationItem.leftBarButtonItem = colorButton
        self.navigationItem.rightBarButtonItem = watchButton
        
       
        
    }
    
    func pushChooseView ()
    {
        
        self.navigationController?.pushViewController(chooser, animated: true)

    }
    
    func pushWatchView()
    {
        watch.delegate = self
        self.navigationController?.pushViewController(watch, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    //update the model to reflect the view
    func receiveLine(linepoints: [CGPoint], color: CGColor)
    {
        var scrnWidth: Float = Float(UIScreen.mainScreen().bounds.width)
        var scrnHeight: Float = Float( UIScreen.mainScreen().bounds.height)
      
        var tempPointFArray: [Drawing.PointF] = []
        for current in linepoints
        {
            //convert linepoint to pointF
            var tempPointF: Drawing.PointF = Drawing.PointF(x: Float(Float(current.x)/scrnWidth), y: Float(Float(current.y)/scrnHeight))
            tempPointFArray.append(tempPointF)
        }
        
        //grab rgb from color
        let components: UnsafePointer<CGFloat> = CGColorGetComponents(color)
        
        //build Drawing.Color from rgb
        var tempColor: Drawing.Color = Drawing.Color(r: Float(components[0]), g: Float(components[1]), b: Float(components[2]), a: Float(components[3]))
            
        model.appendPolyline(Drawing.Polyline(points: tempPointFArray, color: tempColor))



    }
    
    func getUpdate(instance: ColorChooserController, colorSelected: UIColor)
    {
        
        underlyingView.strokeColor = colorSelected.CGColor
        //navigation bar background color reflects color chosen
     
        self.navigationController?.navigationBar.backgroundColor = colorSelected
        
        
    }
    
   
    func reqestAllPoints() -> Drawing {
        return model
    }
    
    func requestSomePoints(percentage: Float) -> Drawing
    {
        return model.getNewModelAsPercentageofSelf(percentage)
    }
    func timerChanged(delta: NSTimeInterval)
    {
        
    }
    
}

