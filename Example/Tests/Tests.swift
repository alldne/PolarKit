// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import PolarKit

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("math") {
            describe("CGVector extension") {
                it("can calculate the angle between two vectors") {
                    let v1 = CGVectorMake(1, 1)
                    let v2 = CGVectorMake(1, 1)
                    expect(v1.getAngle(v2)).to(beCloseTo(0))
                }

                it("can calculate the angle between two vectors") {
                    let v1 = CGVectorMake(-1.333343505859375, -2.5)
                    let v2 = CGVectorMake(-1.333343505859375, -2.5)
                    expect(v1.getAngle(v2)).to(beCloseTo(0))
                }

                it("can calculate the angle between two vectors which is nearby with given hint") {
                    let v1 = CGVectorMake(1, 1)
                    let v2 = CGVectorMake(1, 1)
                    let hint = 0.0
                    expect(v1.getNearbyAngle(v2, hint: hint)).to(beCloseTo(0))
                }

                it("can calculate the angle between two vectors which is nearby with given hint") {
                    let v1 = CGVectorMake(-1.333343505859375, -2.5)
                    let v2 = CGVectorMake(-1.333343505859375, -2.5)
                    let hint = 0.0
                    expect(v1.getNearbyAngle(v2, hint: hint)).to(beCloseTo(0))
                }

                it("can calculate the angle between two vectors which is nearby with given hint") {
                    let v1 = CGVectorMake(1, 1)
                    let v2 = CGVectorMake(1, 1)
                    let hint = 3*M_PI - 1
                    expect(v1.getNearbyAngle(v2, hint: hint)).to(beCloseTo(2*M_PI))
                }

                it("can calculate the angle between two vectors which is nearby with given hint") {
                    let v1 = CGVectorMake(1, 0)
                    let v2 = CGVectorMake(0, 1)
                    let hint = -2*M_PI
                    expect(v1.getNearbyAngle(v2, hint: hint)).to(beCloseTo(-M_PI*3/2))
                }
            }

            describe("bound function") {
                describe("bound input") {
                    context("range [0, 10] with margin 2") {
                        let bound = makeBoundFunction(lower: 0, upper: 10, margin: 2).bound

                        it("bypass input in range") {
                            expect(bound(5)).to(beCloseTo(5))
                        }

                        it("bypass input in range") {
                            expect(bound(10)).to(beCloseTo(10))
                        }

                        it("returns smaller value than input within the margin") {
                            expect(bound(11)).to(beLessThanOrEqualTo(11))
                        }

                        it("returns smaller value than input within the margin") {
                            expect(bound(10.0001)).to(beLessThanOrEqualTo(10.0001))
                        }

                        it("should not return the value bigger than upper bound + margin") {
                            expect(bound(15)).to(beLessThanOrEqualTo(12))
                        }

                        it("should not return the value bigger than upper bound + margin") {
                            expect(bound(20)).to(beLessThanOrEqualTo(12))
                        }

                        it("should not return the value bigger than upper bound + margin") {
                            expect(bound(10*1000000)).to(beLessThanOrEqualTo(12))
                        }

                        it("should not return the value smaller than lower bound - margin") {
                            expect(bound(-10*1000000)).to(beGreaterThanOrEqualTo(-2))
                        }
                    }

                    context("range [-100, 10] with margin 10") {
                        let bound = makeBoundFunction(lower: -100, upper: 10, margin: 10).bound

                        it("bypass input in range") {
                            expect(bound(5)).to(beCloseTo(5))
                        }

                        it("bypass input in range") {
                            expect(bound(-100)).to(beCloseTo(-100))
                        }

                        it("bypass input in range") {
                            expect(bound(10)).to(beCloseTo(10))
                        }

                        it("should not return the value bigger than upper bound + margin") {
                            expect(bound(10*1000000)).to(beLessThanOrEqualTo(20))
                        }

                        it("should not return the value smaller than lower bound - margin") {
                            expect(bound(-10*1000000)).to(beGreaterThanOrEqualTo(-110))
                        }
                    }
                }

                describe("inverse of bound function") {
                    let functions = makeBoundFunction(lower: 0, upper: 10, margin: 2)
                    let bound = functions.bound
                    let inverse = functions.inverse

                    it("should work in the opposite way to the bound") {
                        expect(inverse(bound(10))).to(beCloseTo(10))
                    }

                    it("should work in the opposite way to the bound") {
                        expect(inverse(bound(11))).to(beCloseTo(11))
                    }

                    it("should work in the opposite way to the bound") {
                        expect(inverse(bound(11.999))).to(beCloseTo(11.999))
                    }

                    it("should work in the opposite way to the bound") {
                        expect(inverse(bound(-1.999))).to(beCloseTo(-1.999))
                    }

                    it("should work in the opposite way to the bound") {
                        expect(inverse(bound(10*1000))).to(beCloseTo(10*1000))
                    }

                    it("should work in the opposite way to the bound") {
                        expect(inverse(bound(-10*1000))).to(beCloseTo(-10*1000))
                    }
                }
            }
        }
    }
}
