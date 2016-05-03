//
//  RotatableView.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

class RotatableView: UIView {
    override class func layerClass() -> AnyClass {
        return RotatableLayer.self
    }

    override var layer: RotatableLayer {
        return super.layer as! RotatableLayer
    }

    var offset: Double {
        get {
            return self.layer.offset
        }
        set {
            self.layer.offset = newValue
        }
    }

    var contentView: UIView
    override init(frame: CGRect) {
        self.contentView = UIView(frame: frame)
        super.init(frame: frame)

        // FIXME: without setting a background color explicitly, background color is black (as I know it means no drawing)
        self.backgroundColor = UIColor.clearColor()

        // FIXME: what if self.contentView.removeFromSuperview()?
        self.layer.contentLayer.addSublayer(self.contentView.layer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addSubview(view: UIView) {
        self.contentView.addSubview(view)
    }
}