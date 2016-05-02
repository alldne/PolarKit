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
            self.updateContentLayerFitToSize(newValue.size)
        }
    }

    var contentLayer: PolarCoordinatedLayer = PolarCoordinatedLayer()

    override init() {
        super.init()
        self.addSublayer(self.contentLayer)
        self.updateContentLayerFitToSize(self.bounds.size)
    }

    override init(layer: AnyObject) {
        // This initializer is used to create shadow copies of layers, for example, for the presentationLayer method. 
        // Using this method in any other situation will produce undefined behavior.
        // https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CALayer_class/#//apple_ref/occ/instm/CALayer/initWithLayer:

        super.init(layer: layer)
        if layer is RotatableLayer {
            // FIXME: Unsafe recovering of the reference to contentLayer.
            // RotatableLayer must have one or more layers and the first one should be PolarCoordinatedLayer.
            if let contentLayer = self.sublayers?.first as? PolarCoordinatedLayer {
                self.contentLayer = contentLayer
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class func needsDisplayForKey(key: String) -> Bool {
        // TODO: Not quite clear that returning true for this method causes drawing.
        return key == "offset" || super.needsDisplayForKey(key)
    }

    private func updateContentLayerFitToSize(size: CGSize) {
        self.contentLayer.bounds.size = size
        self.contentLayer.position = CGPointMake(size.width/2, size.height/2)
    }
}
