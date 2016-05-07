//
//  RotatableViewTests.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 5. 7..
//  Copyright © 2016년 CocoaPods. All rights reserved.
//

import FBSnapshotTestCase
import PolarKit

class RotatableViewTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
//        self.recordMode = true
    }

    func makeSubview(text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        return label
    }

    func makeRotatableViewWithSubview(text: String) -> RotatableView {
        let view = RotatableView(frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.lightGrayColor()
        let subview = self.makeSubview(text)
        subview.center = view.center
        view.addSubview(subview)
        return view
    }

    func testBasic() {
        let view = RotatableView(frame: CGRectMake(0, 0, 100, 100))
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testBackgroundColor() {
        let view = RotatableView(frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.blueColor()
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testSubview() {
        let view = self.makeRotatableViewWithSubview("SUBVIEW")
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset45() {
        let view = self.makeRotatableViewWithSubview("OFFSET 45")
        view.offset = M_PI_4

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset360() {
        let view = self.makeRotatableViewWithSubview("OFFSET 360")
        view.offset = 2*M_PI

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset450() {
        let view = self.makeRotatableViewWithSubview("OFFSET 450")
        view.offset = 2*M_PI + M_PI_2

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset900() {
        let view = self.makeRotatableViewWithSubview("OFFSET 900")
        view.offset = 5*M_PI

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative45() {
        let view = self.makeRotatableViewWithSubview("OFFSET -45")
        view.offset = -M_PI_4

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative360() {
        let view = self.makeRotatableViewWithSubview("OFFSET -360")
        view.offset = -2*M_PI

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative450() {
        let view = self.makeRotatableViewWithSubview("OFFSET 450")
        view.offset = -2*M_PI - M_PI_2

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative900() {
        let view = self.makeRotatableViewWithSubview("OFFSET -900")
        view.offset = -5*M_PI

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
