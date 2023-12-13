final class Day12: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    data
      .split(separator: "\n")
      .map { line in
        let parts = line.split(separator: " ")
        return solve(
          springs: parts.first ?? "",
          broken: ArraySlice(parts.last?.split(separator: ",").compactMap { Int($0) } ?? [])
        )
      }
      .reduce(0, +)
  }

  func part2() -> Any {
    data
      .split(separator: "\n")
      .map { line in
        let parts = line.split(separator: " ")
        return solve(
          springs: Array(repeating: parts.first ?? "", count: 5).joined(separator: "?")[...],
          broken: ArraySlice(
            Array(repeating: parts.last ?? "", count: 5).joined(separator: ",").split(
              separator: ","
            ).compactMap { Int($0) })
        )
      }
      .reduce(0, +)
  }

  private func solve(springs: Substring, broken: ArraySlice<Int>) -> Int {
    let key = Key(springs: String(springs), broken: Array(broken))
    if let result = cache[key] {
      return result
    }
    let solution = rawSolve(springs: springs, broken: broken)
    cache[key] = solution
    return solution
  }

  private func rawSolve(springs: Substring, broken: ArraySlice<Int>) -> Int {
    switch springs.first {
    case "#":
      guard let row = broken.first,
        !springs.prefix(row).contains("."),
        springs.count == row
          || springs.count > row && springs[springs.index(springs.startIndex, offsetBy: row)] != "#"
      else {
        return 0
      }
      return solve(springs: springs.dropFirst(row + 1), broken: broken.dropFirst())

    case "?":
      return solve(springs: "#" + springs.dropFirst(), broken: broken)
        + solve(springs: "." + springs.dropFirst(), broken: broken)
    case nil:
      return broken.isEmpty ? 1 : 0
    default:
      return solve(springs: springs.drop { $0 == "." }, broken: broken)
    }
  }

  private struct Key: Hashable {
    let springs: String
    let broken: [Int]
  }

  private var cache: [Key: Int] = [:]
  private let data: String
}
