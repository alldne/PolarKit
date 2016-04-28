//
//  PolarView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class PolarCoordinated: UIView {
    override class func layerClass() -> AnyClass {
        return PolarCoordinatedLayer.self
    }

    override var layer: PolarCoordinatedLayer {
        // CHECK
        return super.layer as! PolarCoordinatedLayer
    }

    var radius: Double {
        set {
            self.layer.radius = newValue
            self.superview?.setNeedsDisplay()
        }
        get {
            return self.layer.radius
        }
    }

    var angle: Double {
        set {
            self.layer.angle = newValue

            // FIXME: Is this necessary?
            self.superview?.setNeedsDisplay()
        }
        get {
            return self.layer.angle
        }
    }

    init(radius: Double, angle: Double, frame: CGRect) {
        super.init(frame: frame)
        self.radius = radius
        self.angle = angle
    }

    convenience init() {
        self.init(radius: 0, angle: 0, frame: CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PolarView: DebugPolarCoordinated {
    override func layoutSubviews() {
        super.layoutSubviews()
        let localCenter = self.convertPoint(self.center, fromView: self.superview)
        for subview in self.subviews {
            if let view  = subview as? PolarCoordinated {
                let x = localCenter.x + CGFloat(view.radius * cos(view.angle))
                let y = localCenter.y + CGFloat(view.radius * sin(view.angle))
                view.center = CGPointMake(x, y)
            }
        }
    }
}

class DebugPolarCoordinated: PolarCoordinated {
    var showBorder: Bool = true {
        didSet {
            if showBorder != oldValue {
                if showBorder {
                    self.layer.borderWidth = CGFloat(2)
                    self.layer.borderColor = UIColor.redColor().CGColor
                } else {
                    self.layer.borderWidth = 0
                    self.layer.borderColor = nil
                }
            }
        }
    }

    override init(radius: Double, angle: Double, frame: CGRect) {
        super.init(radius: radius, angle: angle, frame: frame)
        self.layer.borderWidth = CGFloat(2)
        self.layer.borderColor = UIColor.redColor().CGColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
