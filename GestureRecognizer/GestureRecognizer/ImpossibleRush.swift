//
//  ImpossibleRush.swift
//  GestureRecognizer
//
//  Created by Thuc Nguyen Minh on 10/13/14.
//  Copyright (c) 2014 Techmaster Vietnam. All rights reserved.
//

import UIKit

class ImpossibleRush: UIViewController {
    var impossibleRush , ball1 , ball2 , ball3 , ball4: UIImageView!
    var ballOrder : Int = 1
    var rushOrder : Int = 1
    var viewSize : CGSize!
    var timer : NSTimer!
    var velY: Double = 0.0
    var accY: Double = 3.0
    var y: Double = 0.0
    var angle : Double = 0
    var ballNum = 2
    var pointLabel : UILabel!
    var point = 0
    
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        viewSize = self.view.bounds.size
        impossibleRush = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        impossibleRush.image = UIImage(named: "ImpossibleRush.png")
        impossibleRush.center = CGPoint(x: viewSize.width * 0.5, y: viewSize.height - 80 - impossibleRush.bounds.size.height * 0.5)
        self.view.addSubview(impossibleRush)
        
        
        ball1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        y = Double(ball1.bounds.size.height)
        ball1.image = UIImage(named: "ball1.png")
        ball1.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
        ball1.alpha = 0
        self.view.addSubview(ball1)
        
        ball2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        ball2.image = UIImage(named: "ball2.png")
        ball2.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
        ball2.alpha = 0
        self.view.addSubview(ball2)
        
        ball3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        ball3.image = UIImage(named: "ball3.png")
        ball3.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
        ball3.alpha = 0
        self.view.addSubview(ball3)
        
        ball4 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        ball4.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
        ball4.alpha = 0
        self.view.addSubview(ball4)
        
        pointLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        pointLabel.center = CGPoint(x: viewSize.width - 50, y: 30)
        pointLabel.text = "Point : \(point)"
        self.view.addSubview(pointLabel)
        
        self.view.multipleTouchEnabled = true
        self.view.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "onTap:")
        self.view.addGestureRecognizer(tap)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "loop:", userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func loop(timer: NSTimer) {
        velY += accY
        y += velY
        println("\(ballNum)")
        if (ballNum == 2){
            ball1.alpha = 1
            ball1.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
            if (ball1.frame.maxY >= impossibleRush.frame.minY){
                if ballNum == rushOrder {
                    ball1.alpha = 0
                    ballNum  = Int(arc4random() % 3) + 1
                    velY = 0
                    y = Double(ball1.bounds.size.height)
                    point++
                    pointLabel.text = "Point : \(point)"
                }
            }
        }else if ballNum == 1{
            ball2.alpha = 1
            ball2.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
            if (ball2.frame.maxY >= impossibleRush.frame.minY){
                if ballNum == rushOrder {
                    ball2.alpha = 0
                    ballNum  = Int(arc4random() % 3) + 1
                    velY = 0
                    y = Double(ball1.bounds.size.height)
                    point++
                    pointLabel.text = "Point : \(point)"
                }
            }
        }else if ballNum == 3{
            ball3.alpha = 1
            ball3.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
            if (ball3.frame.maxY >= impossibleRush.frame.minY){
                if ballNum == rushOrder {
                    ball3.alpha = 0
                    ballNum  = Int(arc4random() % 3) + 1
                    velY = 0
                    y = Double(ball1.bounds.size.height)
                    point++
                    pointLabel.text = "Point : \(point)"
                }
            }
        }else if ballNum == 4{
            ball4.alpha = 1
            ball4.center = CGPoint(x: Double(viewSize.width * 0.5), y: y)
            if (ball4.frame.maxY >= impossibleRush.frame.minY){
                if ballNum == rushOrder {
                    ball4.alpha = 0
                    ballNum  = Int(arc4random() % 3) + 1
                    velY = 0
                    y = Double(ball1.bounds.size.height)
                    point++
                    pointLabel.text = "Point : \(point)"
                }
            }
        }
        
        
    }
    
    func onTap (tap: UITapGestureRecognizer) {
        angle += M_PI_2
        impossibleRush.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        rushOrder++
        if rushOrder > 4 {
            rushOrder = 1
        }
    }
}
