/// A utility which executes a generic algorithm twice; once with the given
/// `Sequence`, and again with a `Sequence` which will trigger a test failure
/// if it is iterated-over more than once.
///
public struct SinglePassSequenceChecker<S: Sequence> {
    
    internal static func _check<Result>(
        _ sequence: S,
        file: StaticString = #file, line: UInt = #line,
        validateResults: (XCTAssertionContext, Result, Result) -> Void,
        check: (AnySequence<S.Element>) throws -> Result
    ) rethrows {
        let xct = XCTAssertionContext(file: file, line: line)
        let multiPassResult  = try check(AnySequence(sequence))
        let singlePassResult = try check(AnySequence(SinglePassSequence(sequence, context: xct)))
        validateResults(xct, multiPassResult, singlePassResult)
    }
    
    public static func check<Result>(
        _ sequence: S,
        file: StaticString = #file, line: UInt = #line,
        check: (AnySequence<S.Element>) throws -> Result
    ) rethrows where Result: Equatable {
        try self._check(
            sequence,
            file: file,
            line: line,
            validateResults: { $0.assertEqual($1, $2, "results should match") },
            check: check)
    }
    
    public static func check(
        _ sequence: S,
        file: StaticString = #file, line: UInt = #line,
        check: (AnySequence<S.Element>) throws -> Void
    ) rethrows {
        try self._check(
            sequence,
            file: file,
            line: line,
            validateResults: { _, _ , _ in },
            check: check)
    }
}

fileprivate final class SinglePassSequence<S: Sequence>: Sequence {
    var base: S
    var xct: XCTAssertionContext
    var didMakeIterator = false
    
    init(_ base: S, context: XCTAssertionContext) {
        self.base = base
        self.xct = context
    }
    func makeIterator() -> S.Iterator {
        xct.assertFalse(didMakeIterator, "Iterating single-pass sequence for a second time")
        didMakeIterator = true
        return base.makeIterator()
    }
}
