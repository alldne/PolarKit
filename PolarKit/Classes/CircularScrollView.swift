//
//  CircularScrollView.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

func makeBoundFunction(lower lower: Double, upper: Double, margin: Double) -> (bound: Double -> Double, inverse: Double -> Double) {
    return (
        { (input) in
            if lower <= input && input <= upper {
                return input
            }
            if input < lower {
                let limit = lower - margin
                return limit + pow(margin, 2) / (lower - input + margin)
            }
            let limit = upper + margin
            return limit - pow(margin, 2) / (input - upper + margin)
        }, { (input) in
            if lower <= input && input <= upper {
                return input
            }
            if input < lower {
                let limit = lower - margin
                return lower + margin - pow(margin, 2) / (input - limit)
            }
            let limit = upper + margin
            return upper - margin - pow(margin, 2) / (input - limit)
        }
    )
}

func getTangentialVelocity(center center: CGPoint, point: CGPoint, velocity: CGPoint) -> CGVector {
    let r = point - center
    let v = CGVectorMake(velocity.x, velocity.y)

    let length = (r.dx*v.dy - r.dy*v.dx) / r.length
    let tangentialUnit = CGVectorMake(-r.dy/r.length, r.dx/r.length)
    return tangentialUnit * length
}

func getAngularVelocity(center center: CGPoint, point: CGPoint, velocity: CGPoint) -> Double {
    let t = getTangentialVelocity(center: center, point: point, velocity: velocity)
    if t.length == 0 {
        return 0
    }
    let r = point - center
    if r.dx*t.dy - r.dy*t.dx > 0 {
        return Double(t.length / point.length)
    }
    return Double(-t.length / point.length)
}

public class CircularScrollView: RotatableView {
    override public class func layerClass() -> AnyClass {
        return RotatableScrollLayer.self
    }

    override public var layer: RotatableScrollLayer {
        return super.layer as! RotatableScrollLayer
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        let draggingGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CircularScrollView.dragging(_:)))
        self.addGestureRecognizer(draggingGestureRecognizer)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var bound = makeBoundFunction(lower: 0, upper: 0, margin: M_PI_4)

    public var contentLength: Double = 0 {
        didSet {
            self.bound = makeBoundFunction(lower: 0, upper: self.contentLength, margin: M_PI_4)
        }
    }

    override public var offset: Double {
        willSet {
            if self.layer.animationForKey(CircularScrollView.kAnimationKey) != nil {
                self.cancelAnimation()
            }
        }
        didSet {
            self._dragOffset = self.bound.inverse(offset)
        }
    }

    private var _dragOffset: Double = 0
    private var dragOffset: Double {
        get {
            return self._dragOffset
        }
        set {
            self._dragOffset = newValue
            self.offset = self.bound.bound(newValue)
        }
    }

    private struct TouchInfo {
        var initialPoint: CGVector
        var initialDragOffset: Double
        var offsetFromInitialPoint: Double
    }

    private var touchInfo: TouchInfo!

    static let kInertiaThreshhold = 0.8
    static let kInertiaAnimationDuration = 2.5
    static let kAnimationKey = "scroll-to-offset"

    func dragging(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            self._dragOffset = self.bound.inverse(offset)
            let initialPoint = recognizer.locationInView(self) - self.center
            self.touchInfo = TouchInfo(initialPoint: initialPoint, initialDragOffset: self.dragOffset, offsetFromInitialPoint: 0)
        case .Changed:
            let v = recognizer.locationInView(self) - self.center
            self.touchInfo.offsetFromInitialPoint = v.getNearbyAngle(self.touchInfo.initialPoint, hint: self.touchInfo.offsetFromInitialPoint)
            self.dragOffset = self.touchInfo.initialDragOffset + self.touchInfo.offsetFromInitialPoint
        case .Ended:
            self.touchInfo = nil
            if self.offset < 0 {
                self.scrollToOffset(0, animate: true)
            } else if self.offset > self.contentLength {
                self.scrollToOffset(self.contentLength, animate: true)
            } else {
                let w = getAngularVelocity(center: self.center, point: recognizer.locationInView(self), velocity: recognizer.velocityInView(self))
                if abs(w) > CircularScrollView.kInertiaThreshhold {
                    let t = CircularScrollView.kInertiaAnimationDuration
                    let endPoint = self.offset - w*t - 0.5*(-w)*t
                    self.scrollToOffset(endPoint, animate: true)
                }
            }
        case .Cancelled:
            self.touchInfo = nil
        default:
            break
        }
    }

    public func scrollToOffset(offset: Double, animate: Bool) {
        var offsetInRange = offset
        if offset < 0 {
            offsetInRange = 0
        } else if offset > self.contentLength {
            offsetInRange = self.contentLength
        }

        let anim = CABasicAnimation(keyPath: "offset")
        anim.toValue = offsetInRange
        anim.duration = CircularScrollView.kInertiaAnimationDuration
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.layer.addAnimation(anim, forKey: CircularScrollView.kAnimationKey)
    }

    public func cancelAnimation() {
        self.layer.removeAnimationForKey(CircularScrollView.kAnimationKey)
    }

    // MARK: UIView methods
    override public func layoutSubviews() {
        super.layoutSubviews()
        let localCenter = self.convertPoint(self.center, fromView: self.superview)
        for subview in self.contentView.subviews {
            if let view  = subview as? PolarCoordinatedView {
                let x = localCenter.x + CGFloat(view.radius * cos(view.angle))
                let y = localCenter.y + CGFloat(view.radius * sin(view.angle))
                view.center = CGPointMake(x, y)
            }
        }
    }

    override public func addSubview(view: UIView) {
        super.addSubview(view)
        self.layer.updateSublayerMask()
    }
}
