//
//  PolarCoordinatedViewTests.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 5. 7..
//  Copyright © 2016년 CocoaPods. All rights reserved.
//

import FBSnapshotTestCase
import PolarKit

class PolarCoordinatedViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
//        self.recordMode = true
    }

    func testBasic() {
        print(NSProcessInfo.processInfo().environment["FB_REFERENCE_IMAGE_DIR"])
        let view = PolarCoordinatedView(radius: 0, angle: 0, frame: CGRectMake(0, 0, 100, 100))
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testBackgroundColor() {
        let view = PolarCoordinatedView(radius: 0, angle: 0, frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.blueColor()
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testSubview() {
        let view = PolarCoordinatedView(radius: 10, angle: M_PI_4, frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.lightGrayColor()
        let label = UILabel()
        label.text = "SUBVIEW"
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
