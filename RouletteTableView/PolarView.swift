//
//  PolarView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class PolarView: UIView {
    var radius: Double = 0
    var angle: Double = 0

    init(radius: Double, angle: Double) {
        self.radius = radius
        self.angle = angle
        super.init(frame: CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            if let view  = subview as? PolarView {
                let x = self.center.x + CGFloat(view.radius * cos(view.angle))
                let y = self.center.y + CGFloat(view.radius * sin(view.angle))
                view.center = CGPointMake(x, y)
                view.transform = CGAffineTransformMakeRotation(CGFloat(view.angle))
            }
        }
    }
}
