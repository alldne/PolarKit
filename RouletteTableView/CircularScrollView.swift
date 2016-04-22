//
//  CircularScrollView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

func makeBoundFunction(lower lower: Double, upper: Double, margin: Double) -> (Double -> Double) {
    return { (input) in
        if lower <= input && input <= upper {
            return input
        }
        if input < lower {
            let limit = lower - margin
            return limit + pow(margin, 2) / (lower - input + margin)
        }
        let limit = upper + margin
        return limit - pow(margin, 2) / (input - upper + margin)
    }
}

func makeReverseBoundFunction(lower lower: Double, upper: Double, margin: Double) -> (Double -> Double) {
    return { (input) in
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
}

class CircularScrollView: RotatableView {
    override init(frame: CGRect) {
        self.contentView = PolarView(radius: 0, angle: 0, frame: frame)
        super.init(frame: frame)
        super.addSubview(self.contentView)

        let draggingGestureRecognizer = UIPanGestureRecognizer(target: self, action: "dragging:")
        self.addGestureRecognizer(draggingGestureRecognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var contentView: PolarView

    private var bound = makeBoundFunction(lower: 0, upper: 0, margin: M_PI_4)
    private var boundReverse = makeReverseBoundFunction(lower: 0, upper: 0, margin: M_PI_4)

    var contentLength: Double = 0 {
        didSet {
            self.bound = makeBoundFunction(lower: 0, upper: self.contentLength, margin: M_PI_4)
            self.boundReverse = makeReverseBoundFunction(lower: 0, upper: self.contentLength, margin: M_PI_4)
        }
    }

    var contentOffset: Double {
        get {
            return -self.offset
        }
        set {
            self.offset = -newValue
            self._dragOffset = self.boundReverse(newValue)
        }
    }

    private var _dragOffset: Double = 0
    private var dragOffset: Double {
        get {
            return self._dragOffset
        }
        set {
            self._dragOffset = newValue
            self.contentOffset = self.bound(newValue)
        }
    }

    var polarCoordinatedSubviews: [PolarCoordinated] = []

    private var subviewsToShow: [PolarCoordinated] {
        let lower = self.contentOffset
        let upper = self.contentOffset + M_PI * 2
        return self.polarCoordinatedSubviews.filter { (p) -> Bool in
            return lower <= p.angle && p.angle < upper
        }
    }

    private struct TouchInfo {
        var initialPoint: CGVector
        var initialDragOffset: Double
        var offsetFromInitialPoint: Double
    }

    private var touchInfo: TouchInfo!

    func addSubview(polarCoordinated view: PolarCoordinated) {
        if !self.polarCoordinatedSubviews.contains(view) {
            self.polarCoordinatedSubviews.append(view)
        }

        self.setNeedsLayout()
    }

    func dragging(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            let initialPoint = recognizer.locationInView(self) - self.center
            self.touchInfo = TouchInfo(initialPoint: initialPoint, initialDragOffset: self.dragOffset, offsetFromInitialPoint: 0)
        case .Changed:
            let v = recognizer.locationInView(self) - self.center
            self.touchInfo.offsetFromInitialPoint = v.getNearbyAngle(self.touchInfo.initialPoint, hint: self.touchInfo.offsetFromInitialPoint)
            self.dragOffset = self.touchInfo.initialDragOffset + self.touchInfo.offsetFromInitialPoint
        case .Ended:
            self.touchInfo = nil
        case .Cancelled:
            self.touchInfo = nil
        default:
            break
        }
    }

    // MARK: UIView methods

    override func addSubview(view: UIView) { }

    override func layoutSubviews() {
        self.contentView.frame.size = self.frame.size

        for subview in self.subviewsToShow {
            self.contentView.addSubview(subview)
        }

        for subview in self.contentView.subviews {
            if let polar = subview as? PolarCoordinated where !self.subviewsToShow.contains(polar){
                polar.removeFromSuperview()
            }
        }

        super.layoutSubviews()
    }

}