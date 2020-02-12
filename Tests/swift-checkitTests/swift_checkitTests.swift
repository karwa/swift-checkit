import XCTest
@testable import swift_checkit

final class swift_checkitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_checkit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
