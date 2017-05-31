//
//  PolarCoordinatedLayer.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 25..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

open class PolarCoordinatedLayer: CALayer {
    open var radius: Double = 0
    open var angle: Double = 0 {
        didSet {
            self.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(angle), 0.0, 0.0, 1.0)
        }

    }

    override public init() {
        super.init()
    }

    override public init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? PolarCoordinatedLayer {
            self.radius = layer.radius
            self.angle = layer.angle
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func action(forKey event: String) -> CAAction? {
        if event == "transform" {
            return nil
        }
        return super.action(forKey: event)
    }
}
