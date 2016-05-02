//
//  RotatableScrollLayer.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 29..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class RotatableScrollLayer: RotatableLayer {
    override var offset: Double {
        didSet {
            self.updateSublayerMask()
        }
    }

    var sublayersInContentView: [CALayer]? {
        // FIXME: More safe way needed
        return self.contentLayer.sublayers?[0].sublayers
    }

    func makeMaskLayer(currentScrollOffset: Double, targetOffset: Double) -> CAShapeLayer? {
        // The content of PolarCoordinatedLayer with offset 'x' could lay over range [x-π, x+π].
        // We can ensure that the content is fully shown only if the current scroll offset is x-π.
        // The following range [-3π, π] comes from [x-π-2π, x-π+2π]
        let diff = currentScrollOffset - targetOffset
        if diff > M_PI || diff < -3*M_PI {
            return CAShapeLayer()
        } else if diff == -M_PI {
            return nil
        }

        let r = CGFloat((self.bounds.size.width + self.bounds.size.height)/2)
        let center = CGPointMake(r, r)

        // -3π < diff < -π: clockwise
        // -π < diff < π: counter-clockwise
        var clockwise = false
        if -3*M_PI <= diff && diff <= -M_PI {
            clockwise = true
        }

        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(-M_PI), endAngle: CGFloat(diff), clockwise: clockwise)
        path.addLineToPoint(center)
        path.closePath()

        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.fillColor = UIColor.blackColor().CGColor
        layer.bounds.size = CGSizeMake(2*r, 2*r)
        return layer
    }

    func updateSublayerMask() {
        if let sublayers = self.sublayersInContentView {
            // FIXME: It is not necessary to iterate on every sublayer.
            // Only layers in the range [-3π, π] are needed
            for sub in sublayers {
                if let sub = sub as? PolarCoordinatedLayer {
                    let mask = self.makeMaskLayer(self.offset, targetOffset: sub.angle)
                    mask?.position.y = sub.bounds.height/2
                    mask?.position.x = sub.bounds.width/2 - CGFloat(sub.radius)
                    sub.mask = mask
                }
            }
        }
    }
}
