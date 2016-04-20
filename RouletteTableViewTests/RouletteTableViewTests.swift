//
//  RouletteTableViewTests.swift
//  RouletteTableViewTests
//
//  Created by Yonguk Jeong on 2016. 4. 20..
//  Copyright © 2016년 Yonguk Jeong. All rights reserved.
//

import XCTest
@testable import RouletteTableView

class RouletteTableViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetAngle() {
        func getError(x1 x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, expected: Double) -> Double {
            let p1 = CGPointMake(x1, y1)
            let p2 = CGPointMake(x2, y2)
            let result = getAngle(a: p1, b: p2)
            let error = fabs(result - expected)
            return error
        }

        let MIN_ERROR = 0.0000001
        XCTAssert(getError(x1: 1, y1: 1, x2: 1, y2: 1, expected: 0) < MIN_ERROR)
        XCTAssert(getError(x1: -1.333343505859375, y1: -2.5, x2: -1.333343505859375, y2: -2.5, expected: 0) < MIN_ERROR)
    }
}
