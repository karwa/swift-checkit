import XCTest
import Checkit

class SinglePassSequenceTests: XCTestCase {}

extension SinglePassSequenceTests {
    
    func testStdlib() {
        SinglePassSequenceChecker.check(0..<5) { sequence in sequence.max() }
        SinglePassSequenceChecker.check(0..<5) { sequence in sequence.sorted() }
        SinglePassSequenceChecker.check(0..<5) { sequence in sequence.reversed() }
    }
    
  // TODO: Try to catch this assertion.
    func __disabled_testBadAlgorithm() {
        func badAlgorithm<S: Sequence>(_ s: S) -> S.Element
            where S.Element: Comparable, S.Element: AdditiveArithmetic {
            let min = s.min()!
            let max = s.max()!
            return min + max
        }
        SinglePassSequenceChecker.check(0..<5) { sequence in
                badAlgorithm(sequence)
        }
    }
}
