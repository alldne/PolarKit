//
//  PolarCoordinatedView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class PolarCoordinatedView: UIView {
    override class func layerClass() -> AnyClass {
        return PolarCoordinatedLayer.self
    }

    override var layer: PolarCoordinatedLayer {
        return super.layer as! PolarCoordinatedLayer
    }

    var radius: Double {
        set {
            self.layer.radius = newValue
        }
        get {
            return self.layer.radius
        }
    }

    var angle: Double {
        set {
            self.layer.angle = newValue
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