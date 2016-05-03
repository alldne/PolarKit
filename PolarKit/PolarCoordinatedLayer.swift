//
//  PolarCoordinatedLayer.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 25..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class PolarCoordinatedLayer: CALayer {
    var radius: Double = 0
    var angle: Double = 0 {
        didSet {
            self.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(angle), 0.0, 0.0, 1.0)
        }
    }

    override init() {
        super.init()
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? PolarCoordinatedLayer {
            self.radius = layer.radius
            self.angle = layer.angle
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func actionForKey(event: String) -> CAAction? {
        if event == "transform" {
            return nil
        }
        return super.actionForKey(event)
    }
}