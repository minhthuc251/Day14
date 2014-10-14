//
//  BiA.swift
//  GestureRecognizer
//
//  Created by Thuc Nguyen Minh on 10/9/14.
//  Copyright (c) 2014 Techmaster Vietnam. All rights reserved.
//

import UIKit




class BiA: UIViewController {
    var banBia , gay , bi0 , bi6 , bi8 , bi10 , bi13 , bi15: UIImageView!
    var timer: NSTimer?
    var vX: Double = 0.0
    var vY: Double = 0.0
    var vX2: Double = 0.0
    var vY2: Double = 0.0
    var width: Double = 0.0
    var height: Double = 0.0
    var R = 10.0
    var start = 0
    var notSnook = false
    var impact : Bool = false
    var velocityDelta = CGPoint()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        var viewSize = self.view.bounds.size
        width = Double(viewSize.width)
        height = Double(viewSize.height) - 60
        
        banBia = UIImageView(frame: CGRect(x: 0, y: 0, width: 380, height: 610))
        banBia.image = UIImage(named: "ban1.png")
        self.view.addSubview(banBia)
        
        bi0 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        bi0.image = UIImage(named: "bi0.png")
        bi0.center = CGPointMake(self.banBia.bounds.size.width * 0.5, viewSize.height - 200)
        self.view.addSubview(bi0)
        
        bi6 = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        bi6.image = UIImage(named: "bi6.png")
        bi6.center = CGPointMake(self.banBia.bounds.size.width * 0.5, 290)
        self.view.addSubview(bi6)
        
        gay = UIImageView(frame: CGRect(x: self.banBia.bounds.size.width * 0.5 - 5, y: viewSize.height - 230, width: 10, height: 95))
        gay.image = UIImage(named: "gay.jpg")
        gay.layer.anchorPoint = CGPointMake(0.5, 0)
        
        self.view.addSubview(gay)
        
        view.multipleTouchEnabled = true
        view.userInteractionEnabled = true
        gay.multipleTouchEnabled = true
        gay.userInteractionEnabled = true
        
        let rotate = UIRotationGestureRecognizer(target: self, action: "onRotate:")
        view.addGestureRecognizer(rotate)
        
        let pan = UIPanGestureRecognizer(target: self, action: "onPan:")
        gay.addGestureRecognizer(pan)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "loop:", userInfo: nil, repeats: true)
        timer?.fire()

    }
    
    func onRotate(rotate: UIRotationGestureRecognizer) {
        gay.transform = CGAffineTransformMakeRotation(rotate.rotation)
    }
    
    func onPan(pan: UIPanGestureRecognizer) {
        if(notSnook == false){
        if (pan.state == UIGestureRecognizerState.Began || pan.state == UIGestureRecognizerState.Changed) {
           /* var newPoint = pan.locationInView(self.view)
            var distance = sqrt(Double(newPoint.x - bi0.center.x) * Double(newPoint.x - bi0.center.x) + Double(newPoint.y - bi0.center.y) * Double(newPoint.y - bi0.center.y))
            var cosAlpha = newPoint.x / CGFloat(distance)
            gay.transform = CGAffineTransformMakeRotation(cosAlpha)*/
            
            let velocity = pan.velocityInView(gay)
            vX -= Double(velocity.x) * 5 / width
            vY -= Double(velocity.y) * 5 / height
            
        }
        else if (pan.state == UIGestureRecognizerState.Ended){
            velocityDelta = pan.velocityInView(bi0)
            gay.center = CGPointMake(self.banBia.bounds.size.width * 0.5, self.view.bounds.size.height - 79)
            start = 1
            notSnook = true
        }
        }
        
    }
    
    func loop(timer: NSTimer) {
        if(start == 1 ){
            var x1 = Double(bi0.center.x) + vX
            var y1 = Double(bi0.center.y) + vY
            var x2 = Double(bi6.center.x)
            var y2 = Double(bi6.center.y)
            var d06: Double = 0
            if (impact == false){
            
            //bi 0 cham tuong
            if x1 < R {
                x1 = R
                vX = -vX
            }
            if x1 > width - R {
                x1 = width - R
                vX = -vX
            }
        
            if y1 < R  {
                y1 = R
                vY = -vY
            }
            if y1 > height - R{
                y1 = height - R
                vY = -vY
            }
            bi0.center = CGPoint(x: x1, y: y1)
        }
            
            d06 = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
            if ( d06 <= 20) {
                impact = true
                
                var nomalVectorX = (x2 - x1) / d06
                var nomalVectorY = (y2 - y1) / d06
                var aci : Double = vX * nomalVectorX + vY * nomalVectorY
                var bci : Double = vX2 * nomalVectorX + vY2 * nomalVectorY
                var acf = bci
                var bcf = aci
                vX += (acf - aci) * nomalVectorX
                vY += (acf - aci) * nomalVectorY
                vX2 += (bcf - bci) * nomalVectorX
                vY2 += (bcf - bci) * nomalVectorY
            }
            if ( impact == true){
                
                x2 = Double(bi6.center.x) + vX2
                y2 = Double(bi6.center.y) + vY2
                x1 = Double(bi0.center.x) + vX
                y1 = Double(bi0.center.y) + vY

                //bi 6 cham tuong
                if x2 < R {
                    x2 = R
                    vX2 = -vX2
                }else if x2 > width - R {
                    x2 = width - R
                    vX2 = -vX2
                }else if y2 < R {
                    y2 = R
                    vY2 = -vY2
                }else if y2 > height - R {
                    y2 = height - R
                    vY2 = -vY2
                }
                bi6.center = CGPoint(x: x2, y: y2)
                
                //bi 0 cham tuong
                if x1 < R {
                    x1 = R
                    vX = -vX
                }
                if x1 > width - R {
                    x1 = width - R
                    vX = -vX
                }
                
                if y1 < R  {
                    y1 = R
                    vY = -vY
                }
                if y1 > height - R{
                    y1 = height - R
                    vY = -vY
                }
                
                bi0.center = CGPoint(x: x1, y: y1)
            }
            
            
            
        //Add some friction
            vX = 0.9 * vX
            vY = 0.9 * vY
            vX2 = 0.9 * vX2
            vY2 = 0.9 * vY2
            //println("\(vX) +++ \(vY)")
            if((vX <= 0.07 && vX >= -0.07 ) && (vY <= 0.4 && vY >= -0.4	) && impact == false){
                notSnook = false
                start = 0
            }
            if((vX2 <= 0.07 && vX2 >= -0.07 ) && (vY2 <= 0.4 && vY2 >= -0.4	) && impact == true){
                impact = false
                notSnook = false
                start = 0
            }
        }
    }


}
