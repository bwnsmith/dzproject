//
//  ViewController.swift
//  drawing
//
//  Created by Bowen Smith on 2/20/15.
//  Copyright (c) 2015 Bowen Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tempDrawImage: UIImageView!
    
    var lastPoint : CGPoint?
    let red : CGFloat = 255.0/255.0
    let green : CGFloat = 100.0/255.0
    let blue : CGFloat = 255.0/255.0
    var brush : CGFloat = 2.0
    var opacity : CGFloat = 1.0
    var mouseSwiped : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//Selecting Mode
    
    @IBAction func pencilPressed(sender: AnyObject) {
    }
    
    @IBAction func eraserPressed(sender: AnyObject) {
    }
    
    @IBAction func reset(sender: AnyObject) {
    }
    
    @IBAction func settings(sender: AnyObject) {
    }
    
    @IBAction func save(sender: AnyObject) {
    }
    
//Drawing 
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        mouseSwiped = false
        var touch: AnyObject? = touches .anyObject()
        var lastPoint = touch?.locationInView(self.view)
        println(touch)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        mouseSwiped = true
        var touch: AnyObject? = touches .anyObject()
        var currentPoint = touch?.locationInView(self.view)
    UIGraphicsBeginImageContext(self.view.frame.size)
        self.tempDrawImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        if (lastPoint != nil) {
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint!.x, lastPoint!.y)
        }
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint!.x, currentPoint!.y)
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal)
        
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currentPoint!
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if !mouseSwiped {
            UIGraphicsBeginImageContext(self.view.frame.size)
        self.tempDrawImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity)
            if lastPoint != nil {
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint!.x, lastPoint!.y)
                CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint!.x, lastPoint!.y)
            }
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            CGContextFlush(UIGraphicsGetCurrentContext())
            self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(self.mainImage.frame.size)
        self.mainImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        
        
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        self.mainImage.image!.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
//        self.tempDrawImage.image = nil
        lastPoint = nil
        UIGraphicsEndImageContext()
        
    }
    
}
















