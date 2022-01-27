import XCTest
@testable import RazeCore

final class RazeColorTests: XCTestCase {
    
    func testRedColorEqual() {
        let color = RazeCore.Color.fromHexString(hexString: "FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func testRazeColorEqual() {
        let color = RazeCore.Color.fromHexString(hexString: "450998")
        XCTAssertEqual(color, RazeCore.Color.razeColor)
    }
    
    func testSecondaryRazeColor() {
        let color = RazeCore.Color.fromHexString(hexString: "ABCDEF")
        XCTAssertEqual(color, RazeCore.Color.secondaryColor)
    }

    static var allTests = [
        ("testRedColorEqual", testRedColorEqual),
        ("testRazeColorEqual", testRazeColorEqual),
        ("testSecondaryRazeColor", testSecondaryRazeColor),
    ]
}
