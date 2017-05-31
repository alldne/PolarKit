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

    func makeSubview(_ text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        return label
    }

    func makeRotatableViewWithSubview(_ text: String) -> RotatableView {
        let view = RotatableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.lightGray
        let subview = self.makeSubview(text)
        subview.center = view.center
        view.addSubview(subview)
        return view
    }

    func testBasic() {
        let view = RotatableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testBackgroundColor() {
        let view = RotatableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.blue
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
        view.offset = .pi / 4

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset360() {
        let view = self.makeRotatableViewWithSubview("OFFSET 360")
        view.offset = 2 * .pi

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset450() {
        let view = self.makeRotatableViewWithSubview("OFFSET 450")
        view.offset = 2 * .pi + .pi / 2

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset900() {
        let view = self.makeRotatableViewWithSubview("OFFSET 900")
        view.offset = 5 * .pi

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative45() {
        let view = self.makeRotatableViewWithSubview("OFFSET -45")
        view.offset = -.pi / 4

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative360() {
        let view = self.makeRotatableViewWithSubview("OFFSET -360")
        view.offset = -2 * .pi

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative450() {
        let view = self.makeRotatableViewWithSubview("OFFSET 450")
        view.offset = -2 * .pi - .pi / 2

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffsetNegative900() {
        let view = self.makeRotatableViewWithSubview("OFFSET -900")
        view.offset = -5 * .pi

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
