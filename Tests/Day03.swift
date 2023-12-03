import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {
  private let data = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
  func testPart1() {
    let challenge = Day03(data: data)
    XCTAssertEqual(String(describing: challenge.part1()), "4361")
  }
}
