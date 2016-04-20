//
//  CircularScrollView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

func - (a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPointMake(a.x - b.x, a.y - b.y)
}

func distance(point: CGPoint) -> CGFloat {
    return sqrt(pow(point.x, 2) + pow(point.y, 2))
}

func getAngle(a a: CGPoint, b: CGPoint) -> Double {
    let distA = distance(a)
    let distB = distance(b)
    if distA == 0 || distB == 0 {
        return 0.0
    }

    var cosTheta = (a.x*b.x + a.y*b.y) / (distA * distB)
    // acos() returns NaN for |x| > 1.
    // Theoretically, |cosTheta| <= 1 but due to lack of floating point precision,
    // cosTheta could be slightly bigger or smaller than the range like 1.0000000000000002
    if cosTheta > 1 {
        cosTheta = 1.0
    } else if cosTheta < -1 {
        cosTheta = -1.0
    }
    let rad = acos(cosTheta)

    if a.x*b.y - a.y*b.x < 0 {
        return -rad.native
    }
    return rad.native
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

    var contentOffset: Double {
        get {
            return -1 * self.offset
        }
        set {
            self.offset = -1 * newValue
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

    private var formerTouchPoint: CGPoint!

    func addSubview(polarCoordinated view: PolarCoordinated) {
        if !self.polarCoordinatedSubviews.contains(view) {
            self.polarCoordinatedSubviews.append(view)
        }

        self.setNeedsLayout()
    }

    func dragging(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            self.formerTouchPoint = recognizer.locationInView(self)
        case .Changed:
            let v1 = self.formerTouchPoint - self.center
            let v2 = recognizer.locationInView(self) - self.center
            self.contentOffset += getAngle(a: v2, b: v1)
            self.formerTouchPoint = recognizer.locationInView(self)
        case .Ended:
            self.formerTouchPoint = nil
        case .Cancelled:
            self.formerTouchPoint = nil
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