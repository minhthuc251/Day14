//
//  throwpaper.swift
//  GestureRecognizer
//
//  Created by Thuc Nguyen Minh on 10/10/14.
//  Copyright (c) 2014 Techmaster Vietnam. All rights reserved.
//

import UIKit

class ThrowPaper: UIViewController {
    var paper , trash: UIImageView!
    var width: Double = 0.0
    var height: Double = 0.0
    var vX: Double = 0.0
    var vY: Double = 0.0
    var R = 15.0 //radius of ball
    var timer: NSTimer?
    var notThrow : Bool = false
    var pointLabel : UILabel!
    var point = 0
    var time = 0.0
    var cosAlpha , sinAlpha : Double!

    override func loadView() {
        super.loadView()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        let size = self.view.bounds.size
        width = Double(size.width)
        height = Double(size.height) - 60
        
        trash = UIImageView(image: UIImage(named: "EmptyTrash.png"))
        trash.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        trash.center = CGPointMake(size.width * 0.5, size.height * 0.5 - 200)
        self.view.addSubview(trash)
        
        paper = UIImageView(image: UIImage(named: "paper.png"))
        paper.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        paper.center = CGPointMake(size.width * 0.5, size.height * 0.5 + 100)
        self.view.addSubview(paper)
        
        pointLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        pointLabel.center = CGPoint(x: size.width - 50, y: 30)
        pointLabel.text = "Point : \(point)"
        self.view.addSubview(pointLabel)
        
        let pan = UIPanGestureRecognizer(target: self, action: "panIt:")
        self.view.addGestureRecognizer(pan)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "loop:", userInfo: nil, repeats: true)
        timer?.fire()
        
        }
    func panIt(pan: UIPanGestureRecognizer) {
        if notThrow == false {
            if (pan.state == UIGestureRecognizerState.Began || pan.state == UIGestureRecognizerState.Changed) {
                let velocity = pan.velocityInView(self.view)
                vX += (Double(velocity.x) * 80 / width )
                vY += (Double(velocity.y) * 80 / height)
                notThrow = true
            }
        }
    }
    
    func loop(timer: NSTimer) {
        if ( notThrow == true ){
            
            var distance = sqrt(Double((vX - Double(paper.center.x)) * (vX - Double(paper.center.x))) + Double((vY - Double(paper.center.y)) * (vY - Double(paper.center.y))))
            cosAlpha = (vX - Double(paper.center.x)) / distance
            sinAlpha = (vY - Double(paper.center.y)) / distance
            
            vX = vX * cosAlpha
            vY = vY * sinAlpha - 4
            var x1 = Double(paper.center.x) + vX
            var y1 = Double(paper.center.y) + vY
            if x1 < R {
                x1 = R
                vX = -vX
                println("\(sqrt(vX * vX + vY * vY) / cos(30 / M_PI))")
            }
            if x1 > width - R {
                x1 = width - R
                vX = -vX
            }
        
            if y1 < R {
                y1 = R
                vY = -vY
            }
            if y1 > height - R {
                y1 = height - R
                vY = -vY
            }
            paper.center = CGPoint(x: x1, y: y1)
            if (paper.frame.minX > trash.frame.minX && paper.frame.maxX < trash.frame.maxX && paper.frame.minY < trash.frame.minY && paper.frame.maxY > trash.frame.maxY - 88){
                paper.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 + 100)
                point++
                pointLabel.text = "Point : \(point)"
                vX = 0
                vY = 0
            }
        
            //Add some friction
            vX = 0.9 * vX
            vY = 0.9 * vY
            
            if((vX <= 0.07 && vX >= -0.07 ) && (vY <= 0.4 && vY >= -0.4	)){
                notThrow = false
                paper.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 + 100)
            }
        }
    }
    
}
