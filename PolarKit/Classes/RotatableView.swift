//
//  RotatableView.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

open class RotatableView: UIView {
    override open class var layerClass : AnyClass {
        return RotatableLayer.self
    }

    override open var layer: RotatableLayer {
        return super.layer as! RotatableLayer
    }

    open var offset: Double {
        get {
            return self.layer.offset
        }
        set {
            self.layer.offset = newValue
        }
    }

    var contentView: UIView
    override public init(frame: CGRect) {
        self.contentView = UIView(frame: frame)
        super.init(frame: frame)

        // FIXME: without setting a background color explicitly, background color is black (as I know it means no drawing)
        self.backgroundColor = UIColor.clear

        // FIXME: what if self.contentView.removeFromSuperview()?
        self.layer.contentLayer.addSublayer(self.contentView.layer)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func addSubview(_ view: UIView) {
        self.contentView.addSubview(view)
    }
}
