//
//  RotatableLayer.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 26..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

open class RotatableLayer: CALayer {
    open var offset: Double {
        set {
            self.contentLayer.angle = -newValue
        }
        get {
            return -self.contentLayer.angle
        }
    }

    override open var bounds: CGRect {
        get {
            return super.bounds
        }
        set {
            super.bounds = newValue
            self.updateContentLayerFitToSize(newValue.size)
        }
    }

    var contentLayer: PolarCoordinatedLayer! {
        // FIXME: Unsafe identification of contentLayer
        return self.sublayers?.first as? PolarCoordinatedLayer
    }

    override public init() {
        super.init()
        self.addSublayer(PolarCoordinatedLayer())
        self.updateContentLayerFitToSize(self.bounds.size)
    }

    override public init(layer: Any) {
        // This initializer is used to create shadow copies of layers, for example, for the presentationLayer method.
        // Using this method in any other situation will produce undefined behavior.
        // https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CALayer_class/#//apple_ref/occ/instm/CALayer/initWithLayer:
        super.init(layer: layer)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open class func needsDisplay(forKey key: String) -> Bool {
        return key == "offset" || super.needsDisplay(forKey: key)
    }

    fileprivate func updateContentLayerFitToSize(_ size: CGSize) {
        self.contentLayer.bounds.size = size
        self.contentLayer.position = CGPoint(x: size.width/2, y: size.height/2)
    }
}
