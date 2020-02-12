import XCTest
import Checkit

class FloatingPointCheckerTests: XCTestCase {}

extension FloatingPointCheckerTests {
    
    func testStdlib() {
        FloatingPointChecker.check(Float32.self)
        FloatingPointChecker.check(Float64.self)
        #if os(macOS)
        FloatingPointChecker.check(Float80.self)
        #endif
    }
}
