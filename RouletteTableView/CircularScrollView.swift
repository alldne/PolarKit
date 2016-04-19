//
//  CircularScrollView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 19..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class CircularScrollView: RotatableView {
    override init(frame: CGRect) {
        self.contentView = PolarView(radius: 0, angle: 0, frame: frame)
        self.contentView.layer.borderColor = UIColor.yellowColor().CGColor
        super.init(frame: frame)
        super.addSubview(self.contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addSubview(view: UIView) { }

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

    func addSubview(polarCoordinated view: PolarCoordinated) {
        if !self.polarCoordinatedSubviews.contains(view) {
            self.polarCoordinatedSubviews.append(view)
        }
        self.setNeedsLayout()
    }

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

    var subviewsToShow: [PolarCoordinated] {
        let lower = self.contentOffset
        let upper = self.contentOffset + M_PI * 2
        return self.polarCoordinatedSubviews.filter { (p) -> Bool in
            return lower <= p.angle && p.angle < upper
        }
    }
}