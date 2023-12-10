import XCTest

@testable import AdventOfCode

final class Day10Tests: XCTestCase {
  private let data = """
    ..F7.
    .FJ|.
    SJ.L7
    |F--J
    LJ...
    """

  func testPart1() {
    let challenge = Day10(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "8")
  }
}
