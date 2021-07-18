    import XCTest
    @testable import FileReader

    final class FileReaderTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            XCTAssertEqual(FileReader().text, "Hello, World!")
        }
    }
