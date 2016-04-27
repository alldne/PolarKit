//
//  RotatableLayer.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 26..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class RotatableLayer: CALayer {
    var offset: Double {
        set {
            self.contentLayer.angle = -newValue
        }
        get {
            return -self.contentLayer.angle
        }
    }

    override var bounds: CGRect {
        get {
            return super.bounds
        }
        set {
            super.bounds = newValue
            self.contentLayer.bounds.size = newValue.size
            self.contentLayer.position = CGPointMake(newValue.size.width/2, newValue.size.height/2)
        }
    }
    var contentLayer: PolarCoordinatedLayer = PolarCoordinatedLayer()

    override init() {
        super.init()
        self.addSublayer(self.contentLayer)
        self.contentLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? RotatableLayer {
            self.offset = layer.offset
            self.contentLayer = PolarCoordinatedLayer(layer: layer.contentLayer)
            self.addSublayer(self.contentLayer)
            self.contentLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
