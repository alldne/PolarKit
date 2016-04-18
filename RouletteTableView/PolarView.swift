//
//  PolarView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class PolarView: UIView {
    var radius: Double = 0 {
        didSet {
            self.superview?.setNeedsLayout()
        }
    }

    var angle: Double = 0 {
        didSet {
            self.superview?.setNeedsLayout()
        }
    }

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
        let localCenter = self.convertPoint(self.center, fromView: self.superview)
        for subview in self.subviews {
            if let view  = subview as? PolarView {
                let x = localCenter.x + CGFloat(view.radius * cos(view.angle))
                let y = localCenter.y + CGFloat(view.radius * sin(view.angle))
                view.center = CGPointMake(x, y)
                view.transform = CGAffineTransformMakeRotation(CGFloat(view.angle))
            }
        }
    }
}

class DebugPolarView: PolarView {
    var showBorder: Bool = true {
        didSet {
            self.layer.borderWidth = CGFloat(2)
            self.layer.borderColor = UIColor.redColor().CGColor
        }
    }
}
