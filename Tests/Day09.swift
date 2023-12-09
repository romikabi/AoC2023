import XCTest

@testable import AdventOfCode

final class Day09Tests: XCTestCase {
  func testPart1() {
    let data = """
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
      """
    let challenge = Day09(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "114")
  }
}
