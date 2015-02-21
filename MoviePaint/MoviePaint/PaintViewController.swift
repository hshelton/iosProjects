//
//  ViewController.swift
//  MoviePaint
//
//  Created by u0658884 on 2/11/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class PaintViewController: UIViewController, colorUpdate, ModelUpdater {
    
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
        
        self.navigationItem.leftBarButtonItem = colorButton
        self.navigationItem.rightBarButtonItem = watchButton
        
    }
    
    func pushChooseView ()
    {
        
        self.navigationController?.pushViewController(chooser, animated: true)

    }
    
    func pushWatchView()
    {
        self.navigationController?.pushViewController(watch, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    //update the model to reflect the view
    func receiveLine(linepoints: [CGPoint], color: CGColor)
    {
    
        
        var tempPointFArray: [Drawing.PointF] = []
        for current in linepoints
        {
            //convert linepoint to pointF
            var tempPointF: Drawing.PointF = Drawing.PointF(x: Float(current.x), y: Float(current.y))
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
        //TO DO: Set a display color box equal to chosen color
        //set paintview's color to color chosen
        underlyingView.strokeColor = colorSelected.CGColor
    
        self.navigationController?.navigationBar.backgroundColor = colorSelected
    }
    
    
}

