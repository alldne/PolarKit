// Slightly modified version from
// https://forums.developer.apple.com/thread/25990

import Foundation
let TOLERANCE = 0.0000001

infix operator ==~ { precedence 130 }
func ==~ (left: Double, right: Double) -> Bool
{
    return fabs(left.distanceTo(right)) <= TOLERANCE
}

infix operator !=~ { precedence 130 }
func !=~ (left: Double, right: Double) -> Bool
{
    return !(left ==~ right)
}

infix operator <=~ { precedence 130 }
func <=~ (left: Double, right: Double) -> Bool
{
    return left ==~ right || left <~ right
}

infix operator >=~ { precedence 130 }
func >=~ (left: Double, right: Double) -> Bool
{
    return left ==~ right || left >~ right
}

infix operator <~ { precedence 130 }
func <~ (left: Double, right: Double) -> Bool
{
    return left.distanceTo(right) > TOLERANCE
}

infix operator >~ { precedence 130 }
func >~ (left: Double, right: Double) -> Bool
{
    return left.distanceTo(right) < -TOLERANCE
}
