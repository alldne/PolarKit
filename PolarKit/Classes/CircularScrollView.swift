//
//  CircularScrollView.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

func makeBoundFunction(lower: Double, upper: Double, margin: Double) -> (bound: (Double) -> Double, inverse: (Double) -> Double) {
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

func getTangentialVelocity(center: CGPoint, point: CGPoint, velocity: CGPoint) -> CGVector {
    let r = point - center
    let v = CGVector(dx: velocity.x, dy: velocity.y)

    let length = (r.dx*v.dy - r.dy*v.dx) / r.length
    let tangentialUnit = CGVector(dx: -r.dy/r.length, dy: r.dx/r.length)
    return tangentialUnit * length
}

func getAngularVelocity(center: CGPoint, point: CGPoint, velocity: CGPoint) -> Double {
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

open class CircularScrollView: RotatableView {
    override open class var layerClass : AnyClass {
        return RotatableScrollLayer.self
    }

    override open var layer: RotatableScrollLayer {
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

    fileprivate var bound = makeBoundFunction(lower: 0, upper: 0, margin: .pi / 4)

    open var contentLength: Double = 0 {
        didSet {
            self.bound = makeBoundFunction(lower: 0, upper: self.contentLength, margin: .pi / 4)
        }
    }

    override open var offset: Double {
        willSet {
            if self.layer.animation(forKey: CircularScrollView.kAnimationKey) != nil {
                self.cancelAnimation()
            }
        }
        didSet {
            self._dragOffset = self.bound.inverse(offset)
        }
    }

    fileprivate var _dragOffset: Double = 0
    fileprivate var dragOffset: Double {
        get {
            return self._dragOffset
        }
        set {
            self._dragOffset = newValue
            self.offset = self.bound.bound(newValue)
        }
    }

    fileprivate struct TouchInfo {
        var initialPoint: CGVector
        var initialDragOffset: Double
        var offsetFromInitialPoint: Double
    }

    fileprivate var touchInfo: TouchInfo!

    static let kInertiaThreshhold = 0.8
    static let kInertiaAnimationDuration = 2.5
    static let kAnimationKey = "scroll-to-offset"

    func dragging(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self._dragOffset = self.bound.inverse(offset)
            let initialPoint = recognizer.location(in: self) - self.center
            self.touchInfo = TouchInfo(initialPoint: initialPoint, initialDragOffset: self.dragOffset, offsetFromInitialPoint: 0)
        case .changed:
            let v = recognizer.location(in: self) - self.center
            self.touchInfo.offsetFromInitialPoint = v.getNearbyAngle(self.touchInfo.initialPoint, hint: self.touchInfo.offsetFromInitialPoint)
            self.dragOffset = self.touchInfo.initialDragOffset + self.touchInfo.offsetFromInitialPoint
        case .ended:
            self.touchInfo = nil
            if self.offset < 0 {
                self.scrollToOffset(0, animate: true)
            } else if self.offset > self.contentLength {
                self.scrollToOffset(self.contentLength, animate: true)
            } else {
                let w = getAngularVelocity(center: self.center, point: recognizer.location(in: self), velocity: recognizer.velocity(in: self))
                if abs(w) > CircularScrollView.kInertiaThreshhold {
                    let t = CircularScrollView.kInertiaAnimationDuration
                    let endPoint = self.offset - w*t - 0.5*(-w)*t
                    self.scrollToOffset(endPoint, animate: true)
                }
            }
        case .cancelled:
            self.touchInfo = nil
        default:
            break
        }
    }

    open func scrollToOffset(_ offset: Double, animate: Bool) {
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
        self.layer.add(anim, forKey: CircularScrollView.kAnimationKey)
    }

    open func cancelAnimation() {
        self.layer.removeAnimation(forKey: CircularScrollView.kAnimationKey)
    }

    // MARK: UIView methods
    override open func layoutSubviews() {
        super.layoutSubviews()
        let localCenter = self.convert(self.center, from: self.superview)
        for subview in self.contentView.subviews {
            if let view  = subview as? PolarCoordinatedView {
                let x = localCenter.x + CGFloat(view.radius * cos(view.angle))
                let y = localCenter.y + CGFloat(view.radius * sin(view.angle))
                view.center = CGPoint(x: x, y: y)
            }
        }
    }

    override open func addSubview(_ view: UIView) {
        super.addSubview(view)
        self.layer.updateSublayerMask()
    }
}
