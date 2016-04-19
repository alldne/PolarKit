//
//  RotatableView.swift
//  RouletteTableView
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class RotatableView: PolarView {
    var offset: Double = 0 {
        didSet {
            self.contentView.angle = offset
        }
    }

    var contentView: PolarCoordinated
    init(frame: CGRect) {
        self.contentView  = PolarCoordinated(radius: 0, angle: 0, frame: frame)
        super.init(radius: 0, angle: 0, frame: frame)
        super.addSubview(self.contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addSubview(view: UIView) {
        self.contentView.addSubview(view)
    }

    override func layoutSubviews() {
        self.contentView.bounds.size = self.bounds.size
        super.layoutSubviews()
    }
}