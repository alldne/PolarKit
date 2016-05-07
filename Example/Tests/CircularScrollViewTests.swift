//
//  CircularScrollViewTests.swift
//  PolarKit
//
//  Created by Yonguk Jeong on 2016. 5. 7..
//  Copyright © 2016년 CocoaPods. All rights reserved.
//

import FBSnapshotTestCase
import PolarKit

class CircularScrollViewTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
//        self.recordMode = true
    }

    func makeCircularScrollView() -> CircularScrollView {
        let circular = CircularScrollView(frame: CGRectMake(0, 0, 100, 100))
        let n = 24
        let contentLength = 4 * M_PI
        let ang = contentLength / Double(n)
        for i in 0..<n {
            let p = PolarCoordinatedView(radius: 30, angle: ang * Double(i), frame: CGRectMake(0, 0, 30, 20))
            let ratio = CGFloat(Double(i) / Double(n))
            p.backgroundColor = UIColor(red: ratio, green: ratio, blue: 1 - ratio, alpha: 1)
            let label = UILabel()
            label.text = "\(i)"
            label.font = UIFont.systemFontOfSize(8)
            label.sizeToFit()
            label.textColor = UIColor(red: 1 - ratio, green: 1 - ratio, blue: ratio, alpha: 1)
            label.center = p.center
            p.addSubview(label)
            p.layer.opacity = 0.5
            circular.addSubview(p)
        }

        circular.contentLength = contentLength
        return circular
    }

    func testBasic() {
        let view = CircularScrollView(frame: CGRectMake(0, 0, 100, 100))
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testBackgroundColor() {
        let view = CircularScrollView(frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.blueColor()
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func makeSubview(text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFontOfSize(8)
        label.sizeToFit()
        label.backgroundColor = UIColor.brownColor()
        return label
    }

    func testSubview() {
        let view = CircularScrollView(frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.lightGrayColor()
        let subview = self.makeSubview("SUBVIEW")

        subview.center = view.center
        view.addSubview(subview)

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func makePolarCoordinatedSubview(text: String) -> PolarCoordinatedView {
        let polar = PolarCoordinatedView()
        let label = self.makeSubview(text)
        polar.frame.size = label.frame.size
        polar.center = label.center
        polar.addSubview(label)
        polar.layer.borderColor = UIColor.redColor().CGColor
        polar.layer.borderWidth = 1.0
        return polar
    }

    func makeCircularScrollViewWithPolarCoordinatedSubview(text: String, modifySubview: (PolarCoordinatedView -> Void)? = nil) -> CircularScrollView {
        let view = CircularScrollView(frame: CGRectMake(0, 0, 100, 100))
        view.backgroundColor = UIColor.lightGrayColor()
        let subview = self.makePolarCoordinatedSubview(text)
        modifySubview?(subview)
        view.addSubview(subview)
        return view
    }

    func testPolarCoordinatedSubview() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR 0")

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testPolarCoordinatedSubview_radius20() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR") { subview in
            subview.radius = 20
        }

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testPolarCoordinatedSubview_angle45_radius20() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR") { subview in
            subview.angle = M_PI_4
            subview.radius = 20
        }

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testPolarCoordinatedSubview_angle45() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR 45") { subview in
            subview.angle = M_PI_4
        }

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testPolarCoordinatedSubview_angle360() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR 360") { subview in
            subview.angle = 2*M_PI
        }

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset0() {
        let view = self.makeCircularScrollView()
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset45() {
        let view = self.makeCircularScrollView()
        view.offset = M_PI_4
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset360() {
        let view = self.makeCircularScrollView()
        view.offset = 2*M_PI
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset540() {
        let view = self.makeCircularScrollView()
        view.offset = 3*M_PI
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
