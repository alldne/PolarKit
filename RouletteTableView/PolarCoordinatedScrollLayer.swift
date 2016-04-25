//
//  PolarCoordinatedScrollLayer.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 25..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

typealias Radian = Double
class PolarCoordinatedScrollLayer: CALayer {
    var offset: Radian = 0.0
    var _sublayers: [PolarCoordinatedLayer] = []
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? PolarCoordinatedScrollLayer {
            self.offset = layer.offset
        }
    }

    override class func needsDisplayForKey(key: String) -> Bool {
        return key == "offset" || super.needsDisplayForKey(key)
    }

    override func display() {
        // filter sublayer (offset +- 2π)
        let upper = self.offset + 2*M_PI
        let lower = self.offset - 2*M_PI
        for layer in self._sublayers {
            if lower <= layer.angle && layer.angle <= upper {
                super.addSublayer(layer)
            } else {
                layer.removeFromSuperlayer()
            }
        }

        // update masks for them
        super.display()
    }

    override func addSublayer(layer: CALayer) {
        if let layer = layer as? PolarCoordinatedLayer {
            self._sublayers.append(layer)
        } else {
            assertionFailure()
        }
    }
}
