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
        func test(x1 x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, expected: Double) -> Bool {
            let p1 = CGPointMake(x1, y1)
            let p2 = CGPointMake(x2, y2)
            let result = getAngle(a: p1, b: p2)
            return result ==~ expected
        }
        XCTAssert(test(x1: 1, y1: 1, x2: 1, y2: 1, expected: 0))
        XCTAssert(test(x1: -1.333343505859375, y1: -2.5, x2: -1.333343505859375, y2: -2.5, expected: 0))
    }

    func testGetNearbyAngle() {
        func test(x1 x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, currentPosition: Double, expected: Double) -> Bool {
            let p1 = CGPointMake(x1, y1)
            let p2 = CGPointMake(x2, y2)
            let result = getNearbyAngle(a: p1, b: p2, currentPositon: currentPosition)
            return result ==~ expected
        }
        XCTAssert(test(x1: 1, y1: 1, x2: 1, y2: 1, currentPosition: 0.0, expected: 0))
        XCTAssert(test(x1: -1.333343505859375, y1: -2.5, x2: -1.333343505859375, y2: -2.5, currentPosition: 0.0, expected: 0))
        XCTAssert(test(x1: 1, y1: 1, x2: 1, y2: 1, currentPosition: 3*M_PI - 1, expected: 2*M_PI))
        XCTAssert(test(x1: 1, y1: 0, x2: 0, y2: 1, currentPosition: -2*M_PI, expected: -M_PI*3/2))

    }

    func testBoundFunction() {
        do {
            let bound = makeBoundFunction(lower: 0, upper: 10, margin: 2)
            XCTAssert(bound(0) == 0)
            XCTAssert(bound(5) == 5)
            XCTAssert(bound(10) == 10)
            XCTAssert(bound(11) <=~ 11)
            XCTAssert(bound(15) <=~ 12)
            XCTAssert(bound(20) <=~ 12)
            XCTAssert(bound(10.0001) <=~ 10.0001)
            XCTAssert(bound(10*1000000) <=~ 12)
            XCTAssert(bound(-10*100000) >=~ -2)
        }

        do {
            let bound = makeBoundFunction(lower: -100, upper: 10, margin: 10)
            XCTAssert(bound(-100) == -100)
            XCTAssert(bound(5) == 5)
            XCTAssert(bound(10) == 10)
            XCTAssert(bound(10*1000000) <=~ 20)
            XCTAssert(bound(-10*100000) >=~ -110)
        }
    }
}
