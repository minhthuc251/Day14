//
//  DemoTap.swift
//  GestureRecognizer
//
//  Created by Trinh Minh Cuong on 10/3/14.
//  Copyright (c) 2014 Techmaster Vietnam. All rights reserved.
//

import UIKit

class DemoTap: UIViewController {
    var grass: UIImageView?
    
    override func loadView() {
        super.loadView()
        self.edgesForExtendedLayout = UIRectEdge.None
        grass = UIImageView(frame: self.view.bounds)
        grass?.image = UIImage(named: "grass.png")
        self.view.addSubview(grass!)
        
        let tap = UITapGestureRecognizer(target: self, action: "onTap:")
        self.view.addGestureRecognizer(tap)
    }
    
    func onTap (tap: UITapGestureRecognizer) {
        let point = tap.locationInView(self.view)
        println("tap at x = \(point.x), y = \(point.y)")
    }
}
