//
//  PolarCoordinatedView.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 18..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import UIKit

open class PolarCoordinatedView: UIView {
    override open class var layerClass : AnyClass {
        return PolarCoordinatedLayer.self
    }

    override open var layer: PolarCoordinatedLayer {
        return super.layer as! PolarCoordinatedLayer
    }

    open var radius: Double {
        set {
            self.layer.radius = newValue
        }
        get {
            return self.layer.radius
        }
    }

    open var angle: Double {
        set {
            self.layer.angle = newValue
        }
        get {
            return self.layer.angle
        }
    }

    public init(radius: Double, angle: Double, frame: CGRect) {
        super.init(frame: frame)
        self.radius = radius
        self.angle = angle
    }

    convenience public init() {
        self.init(radius: 0, angle: 0, frame: CGRect.zero)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
