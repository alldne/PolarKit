//
//  PolarCoordinatedLayer.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 25..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

public class PolarCoordinatedLayer: CALayer {
    public var radius: Double = 0
    public var angle: Double = 0 {
        didSet {
            self.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(angle), 0.0, 0.0, 1.0)
        }

    }

    override public init() {
        super.init()
    }

    override public init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? PolarCoordinatedLayer {
            self.radius = layer.radius
            self.angle = layer.angle
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func actionForKey(event: String) -> CAAction? {
        if event == "transform" {
            return nil
        }
        return super.actionForKey(event)
    }
}