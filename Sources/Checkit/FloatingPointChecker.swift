
public struct FloatingPointChecker {
    
    // TODO: Add base 'FloatingPoint' checks.

    public static func check<T: BinaryFloatingPoint>(_ float: T.Type, file: StaticString = #file, line: UInt = #line) {
        let xct = XCTAssertionContext(file: file, line: line)
        runFloatingPointTests(float, xct)
    }
}

// BinaryFloatingPoint checks.

extension FloatingPointChecker {
    
    @inline(never)
    static func runFloatingPointTests<T: BinaryFloatingPoint>(_ float: T.Type, _ xct: XCTAssertionContext) {
        _testBasicProperties(float, xct)
        _testImplementationGotchas(float, xct)
    }
    
    @inline(never)
    static func _testBasicProperties<T: BinaryFloatingPoint>(_ float: T.Type, _ xct: XCTAssertionContext) {
        // TODO: Floating point checks are still very thin.
        
        // Some checks:
        // If x is -leastNonzeroMagnitude, then x.nextUp is -0.0.
        do {
            var _x = T.leastNonzeroMagnitude.nextDown
            xct.assert(_x.isZero && _x.sign == .plus)
            _x = (-T.leastNonzeroMagnitude).nextUp
            xct.assert(_x.isZero && _x.sign == .minus)
        }
        xct.assertEqual(T.leastNonzeroMagnitude.significandWidth, 0)
        xct.assertEqual(T.leastNonzeroMagnitude.nextUp.significandWidth, 0)
        xct.assertEqual(T.leastNonzeroMagnitude.nextUp.nextUp.significandWidth, 1)
        xct.assertGreaterThan(T(-Float(0)).ulp, 0)
        xct.assertEqual((0 as T).binade, -T(0) + -0.0)

        xct.assertEqual(T.leastNonzeroMagnitude.binade * -1, -T.zero.ulp)
        xct.assertEqual(-T.leastNonzeroMagnitude.nextUp.binade, -(T.zero.ulp * 2 + -0.0))
        
        xct.assertGreaterThan(T.greatestFiniteMagnitude, T(1 << T.significandBitCount))
        xct.assert(T(1.0).exponentBitPattern == (1 << (T.exponentBitCount - 1) - 1))
    }
    
    @inline(never)
    static func _testImplementationGotchas<T: BinaryFloatingPoint>(_ float: T.Type, _ xct: XCTAssertionContext) {
        let _: T = T(-Float(0)) // This can infinitely recurse
    }
}

