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
        let view = PolarCoordinatedView(radius: 0, angle: 0, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testBackgroundColor() {
        let view = PolarCoordinatedView(radius: 0, angle: 0, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.blue
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testSubview() {
        let view = PolarCoordinatedView(radius: 10, angle: .pi / 4, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.text = "SUBVIEW"
        label.sizeToFit()
        label.center = view.center
        view.addSubview(label)
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
