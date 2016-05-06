//
//  CGGeometryExtensions.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 4. 22..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import CoreGraphics

func - (a: CGPoint, b: CGPoint) -> CGVector {
    return CGVectorMake(a.x - b.x, a.y - b.y)
}

func * (a: CGVector, f: CGFloat) -> CGVector {
    return CGVectorMake(a.dx*f, a.dy*f)
}

let PIx2 = 2 * M_PI
extension CGVector {
    var length: CGFloat {
        return sqrt(pow(self.dx, 2) + pow(self.dy, 2))
    }

    func getAngle(v: CGVector) -> Double {
        let lengthA = self.length
        let lengthB = v.length

        if lengthA == 0 || lengthB == 0 {
            return 0.0
        }
        var cosTheta = (self.dx*v.dx + self.dy*v.dy) / (lengthA * lengthB)
        // acos() returns NaN for |x| > 1.
        // Theoretically, |cosTheta| <= 1 but due to lack of floating point precision,
        // cosTheta could be slightly bigger or smaller than the range like 1.0000000000000002
        if cosTheta > 1 {
            cosTheta = 1.0
        } else if cosTheta < -1 {
            cosTheta = -1.0
        }
        let rad = acos(cosTheta)

        if self.dx*v.dy - self.dy*v.dx < 0 {
            return -rad.native
        }
        return rad.native
    }

    func getNearbyAngle(v: CGVector, hint: Double) -> Double {
        let angle = self.getAngle(v)
        let alpha = hint % PIx2

        if angle < alpha - M_PI {
            return hint - alpha + angle + PIx2
        } else if angle > alpha + M_PI {
            return hint - alpha + angle - PIx2
        }
        return hint - alpha + angle
    }
}

extension CGPoint {
    var length: CGFloat {
        return sqrt(pow(self.x, 2) + pow(self.y, 2))
    }
}