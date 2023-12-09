struct Day09: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    data.split(separator: "\n").map { line in
      var nums = line.split(separator: " ").map(String.init).compactMap(Int.init)
      var lasts = [nums.last ?? 0]
      while !nums.allSatisfy({ $0 == 0 }) {
        nums = nums.adjacentPairs().map { $1 - $0 }
        lasts.append(nums.last ?? 0)
      }
      return lasts.reduce(0, +)
    }
    .reduce(0, +)
  }

  private let data: String
}
