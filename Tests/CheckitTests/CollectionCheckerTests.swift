import XCTest
import Checkit

class CollectionCheckerTests: XCTestCase {}

extension CollectionCheckerTests {
    
    func testStdlib_empty() {
        CollectionChecker.check([Int]())
        CollectionChecker.check(EmptyCollection<String>())
        CollectionChecker.check(0 ..< 0)
        CollectionChecker.check(Int.max ..< Int.max)
        CollectionChecker.check(Int.min ..< Int.min)
    }
    
    func testStdlib_single() {
        CollectionChecker.check([42])
        CollectionChecker.check(CollectionOfOne(3.141))
        CollectionChecker.check(0 ..< 1)
        CollectionChecker.check(-1 ..< 0)
        CollectionChecker.check(Int.max.words)
        CollectionChecker.check(Int.max - 1 ..< Int.max)
        CollectionChecker.check(Int.min ..< Int.min + 1)
    }

    func testStdlib() {
        CollectionChecker.check([1, 3])
        CollectionChecker.check("Hello everybody! 👋👨‍⚕️")
        CollectionChecker.check(0..<13)
        let dictionary = ["Hi,": 3, "Dr.": 42, "Nick": -99, "!": Int.max]
        CollectionChecker.check(dictionary)
        CollectionChecker.check(dictionary.keys)
        CollectionChecker.check(dictionary.keys.joined() as FlattenSequence)
        CollectionChecker.check(dictionary.values)
        CollectionChecker.check(Set(dictionary.keys.joined()))
        CollectionChecker.check((0..<20).reversed() as ReversedCollection)
    }
}
