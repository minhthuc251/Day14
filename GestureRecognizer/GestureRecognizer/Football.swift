//
//  ThrowBall.swift
//  GestureRecognizer
//
//  Created by Trinh Minh Cuong on 10/3/14.
//  Copyright (c) 2014 Techmaster Vietnam. All rights reserved.
//

import UIKit

class Football: UIViewController {
    var ball: UIImageView?
    var gate , goalKeeper , background : UIImageView!
    var point : UILabel!
    var vX: Double = 0.0
    var vY: Double = 0.0
    var width: Double = 0.0
    var height: Double = 0.0
    var R = 32.0 //radius of ball
    var timer: NSTimer?
    var vKeeper = 5.0
    var kickPoint : Int = 0
    var start : Bool = true
    override func loadView() {
        super.loadView()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor.whiteColor()
        let size = self.view.bounds.size
        width = Double(size.width)
        height = Double(size.height) - 60
        
        
        
        background = UIImageView(image: UIImage(named: "background.jpg"))
        background.frame = CGRect(x: 0, y: 0, width: 450, height: 640)
        background.center = CGPointMake(size.width * 0.5, background.bounds.size.height * 0.5)
        self.view.addSubview(background)
        
        point = UILabel(frame: CGRect(x: 250, y: 540, width: 80, height: 50))
        point.text = "Point : \(kickPoint)"
        point.textAlignment = NSTextAlignment.Center
        self.view.addSubview(point)
        
        gate = UIImageView(image: UIImage(named: "gate.png"))
        gate.frame = CGRect(x: 0, y: 0, width: 250, height: 132)
        gate.center = CGPointMake(size.width * 0.5, gate.bounds.size.height * 0.5 )
        self.view.addSubview(gate)

        goalKeeper = UIImageView(image: UIImage(named: "keeper.png"))
        goalKeeper.frame = CGRect(x: 0, y: 0, width: 82, height: 120)
        goalKeeper.center = CGPointMake(size.width * 0.5, goalKeeper.bounds.size.height * 0.5 + 30 )
        self.view.addSubview(goalKeeper)
        
        ball = UIImageView(image: UIImage(named: "football.png"))
        ball?.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        ball?.center = CGPoint(x: size.width * 0.5, y: size.height - 60 - ball!.bounds.size.height - 150)
        self.view.addSubview(ball!)
        ball!.multipleTouchEnabled = true
        ball!.userInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: "panIt:")
        ball?.addGestureRecognizer(pan)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "loop:", userInfo: nil, repeats: true)
        timer?.fire()
        
    }
    
    func panIt(pan: UIPanGestureRecognizer) {
        if (pan.state == UIGestureRecognizerState.Began || pan.state == UIGestureRecognizerState.Changed) {
            let velocity = pan.velocityInView(self.view)
            vX += Double(velocity.x) * 2 / width
            vY += Double(velocity.y) * 2 / height
            start = true
        }
    }
    
    func loop(timer: NSTimer) {
        if(start == true){
            var x1 = Double(ball!.center.x) + vX
            var y1 = Double(ball!.center.y) + vY
            var x2 = Double(goalKeeper.center.x) + vKeeper
            var y2 = Double(goalKeeper.center.y)
            if x1 < R {
                x1 = R
                vX = -vX
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
            if(x2 + Double(self.goalKeeper.bounds.size.width) * 0.5 >= Double(self.view.bounds.size.width) * 0.5 + Double   (self.gate.bounds.size.width) * 0.5){
                x2  = Double(self.view.bounds.size.width) * 0.5 + Double(self.gate.bounds.size.width) * 0.5 - Double(self.goalKeeper.bounds.size.width) * 0.5
                vKeeper *= -1
            }else if (x2 - Double(self.goalKeeper.bounds.size.width) * 0.5 <= Double(self.view.bounds.size.width) * 0.5 -   Double(self.gate.bounds.size.width) * 0.5){
                x2  = Double(self.view.bounds.size.width) * 0.5 - Double(self.gate.bounds.size.width) * 0.5 + Double(self.goalKeeper.bounds.size.width) * 0.5
                vKeeper *= -1
            }
        
            ball!.center = CGPoint(x: x1, y: y1)
            goalKeeper.center = CGPoint(x: x2, y: y2)
            if  CGRectContainsRect(goalKeeper.frame, ball!.frame){
                vY = -vY
                vX = -vX
            }else if  CGRectContainsRect(gate.frame, ball!.frame) {
                start = false
                ball?.center = CGPoint(x: self.view.bounds.width * 0.5, y: self.view.bounds.height - 60 - ball!.bounds.size.height - 150)
                kickPoint++
                point.text = "Point : \(kickPoint)"
            }
        //Add some friction
            vX = 0.9 * vX
            vY = 0.9 * vY
            //println("\(vX) ++ \(vY)")
                if((vX <= 0.1 && vX >= -0.1 ) && (vY <= 0.5 && vY >= -0.5	)){
                    start = false
                    ball?.center = CGPoint(x: self.view.bounds.width * 0.5, y: self.view.bounds.height - 60 - ball!.bounds.size.height - 150)
            }
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}
