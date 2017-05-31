//
//  RotatableScrollLayer.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 29..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

open class RotatableScrollLayer: RotatableLayer {
    override open var offset: Double {
        didSet {
            self.updateSublayerMask()
        }
    }

    override open var bounds: CGRect {
        didSet {
            self.updateSublayerMask()
        }
    }

    var sublayersInContentView: [CALayer]? {
        // FIXME: More safe way needed
        return self.contentLayer.sublayers?[0].sublayers
    }

    func makeMaskLayer(_ currentScrollOffset: Double, targetOffset: Double) -> CAShapeLayer? {
        // The content of PolarCoordinatedLayer with offset 'x' could lay over range [x-π, x+π].
        // We can ensure that the content is fully shown only if the current scroll offset is x-π.
        // The following range [-3π, π] comes from [x-π-2π, x-π+2π]
        let diff = currentScrollOffset - targetOffset
        if diff > Double.pi || diff < -3*Double.pi {
            return CAShapeLayer()
        } else if diff == -Double.pi {
            return nil
        }

        let r = CGFloat((self.bounds.size.width + self.bounds.size.height)/2)
        let center = CGPoint(x: r, y: r)

        // -3π < diff < -π: clockwise
        // -π < diff < π: counter-clockwise
        var clockwise = false
        if -3*Double.pi <= diff && diff <= -Double.pi {
            clockwise = true
        }

        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(-Double.pi), endAngle: CGFloat(diff), clockwise: clockwise)
        path.addLine(to: center)
        path.close()

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.black.cgColor
        layer.bounds.size = CGSize(width: 2*r, height: 2*r)
        return layer
    }

    func updateSublayerMask() {
        // FIXME: Dear me,
        // This method modifies sublayers. And init(layer: AnyObject) does not do a deep copy of its sublayers.
        // So calling this method during the animation eventually changes the modelLayer, not the presentationLayer. It's not nice but intended.
        // But there's a exceptional case. If an animation is fired while the other animation is on-the-fly, CoreAnimation do a deep-copy of its sublayers.
        // And calling this method on that moment throws an exception: 'CALayerInvalidTree', reason: 'expecting model layer not copy: ...'.
        // I failed to find documentation about it and obviously there's no source codes I can look into.
        // I just observed that the MOMENT is only 1 frame long so decided to ignore it.
        // The following guard statement is a temporary fix.
        guard let modelLayer = self.model() as? RotatableScrollLayer, modelLayer.contentLayer === self.contentLayer else {
            return
        }
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
