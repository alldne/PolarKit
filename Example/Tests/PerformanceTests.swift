//
//  PerformanceTests.swift
//  PolarKit
//
//  Created by jojo on 08/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import PolarKit

class PerformanceTests: XCTestCase {

    var viewController: UIViewController!
    override func setUp() {
        super.setUp()

        viewController = UIViewController()
        UIApplication.shared.delegate?.window??.rootViewController = viewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        let R = CGFloat(150)
        let n = 24

        let scrollView = CircularScrollView(frame: CGRect(x: 0, y: 0, width: 2 * R, height: 2 * R))

        let contentLength = 4 * Double.pi
        let ang = contentLength / Double(n)
        for i in 0..<n {
            let p = PolarCoordinatedView(radius: Double(R - 50), angle: ang * Double(i), frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            let ratio = CGFloat(Double(i) / Double(n))
            p.backgroundColor = UIColor(red: ratio, green: ratio, blue: 1 - ratio, alpha: 1)
            let label = UILabel()
            label.text = "\(i)"
            label.sizeToFit()
            label.textColor = UIColor(red: 1 - ratio, green: 1 - ratio, blue: ratio, alpha: 1)
            label.center = p.center
            p.addSubview(label)
            scrollView.addSubview(p)
        }

//        self.container.addSubview(self.circularScrollView)
        scrollView.contentLength = contentLength

        viewController.view.addSubview(scrollView)
        scrollView.center.x = viewController.view.frame.width / 2
        scrollView.center.y = viewController.view.frame.height / 2

        // This is an example of a performance test case.
        self.measure {
            let anim = CABasicAnimation(keyPath: "offset")
            anim.toValue = Double.pi * 2
            anim.duration = 2.0
            anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            scrollView.layer.add(anim, forKey: "anim")
        }
    }
    
}
