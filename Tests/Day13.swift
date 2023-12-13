import XCTest

@testable import AdventOfCode

final class Day13Tests: XCTestCase {
  private let data = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

  func testPart1() async {
    let challenge = Day13(data: data)
    let result = await challenge.part1()
    XCTAssertEqual(String(describing: result), "405")
  }
}
