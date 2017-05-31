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
        let circular = CircularScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let n = 24
        let contentLength = 4 * Double.pi
        let ang = contentLength / Double(n)
        for i in 0..<n {
            let p = PolarCoordinatedView(radius: 30, angle: ang * Double(i), frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            let ratio = CGFloat(Double(i) / Double(n))
            p.backgroundColor = UIColor(red: ratio, green: ratio, blue: 1 - ratio, alpha: 1)
            let label = UILabel()
            label.text = "\(i)"
            label.font = UIFont.systemFont(ofSize: 8)
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
        let view = CircularScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testBackgroundColor() {
        let view = CircularScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.blue
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func makeSubview(_ text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 8)
        label.sizeToFit()
        label.backgroundColor = UIColor.brown
        return label
    }

    func testSubview() {
        let view = CircularScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.lightGray
        let subview = self.makeSubview("SUBVIEW")

        subview.center = view.center
        view.addSubview(subview)

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func makePolarCoordinatedSubview(_ text: String) -> PolarCoordinatedView {
        let polar = PolarCoordinatedView()
        let label = self.makeSubview(text)
        polar.frame.size = label.frame.size
        polar.center = label.center
        polar.addSubview(label)
        polar.layer.borderColor = UIColor.red.cgColor
        polar.layer.borderWidth = 1.0
        return polar
    }

    func makeCircularScrollViewWithPolarCoordinatedSubview(_ text: String, modifySubview: ((PolarCoordinatedView) -> Void)? = nil) -> CircularScrollView {
        let view = CircularScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.lightGray
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
            subview.angle = .pi / 4
            subview.radius = 20
        }

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testPolarCoordinatedSubview_angle45() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR 45") { subview in
            subview.angle = .pi / 4
        }

        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testPolarCoordinatedSubview_angle360() {
        let view = self.makeCircularScrollViewWithPolarCoordinatedSubview("POLAR 360") { subview in
            subview.angle = 2*Double.pi
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
        view.offset = .pi / 4
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset360() {
        let view = self.makeCircularScrollView()
        view.offset = 2*Double.pi
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

    func testOffset540() {
        let view = self.makeCircularScrollView()
        view.offset = 3*Double.pi
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }
}
