struct Day13: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() async -> Any {
    await calculate(smudges: 0)
  }

  func part2() async -> Any {
    await calculate(smudges: 1)
  }

  private func calculate(smudges: Int) async -> Int {
    let patterns = data.split(separator: "\n\n")

    return await withTaskGroup(of: Int.self) { group in
      for pattern in patterns {
        group.addTask {
          return await calculate(pattern, smudges: smudges)
        }
      }

      return await group.reduce(0, +)
    }
  }

  @Sendable private func calculate(_ pattern: Substring, smudges: Int) async -> Int {
    let rows = pattern.split(separator: "\n").map(Array.init)
    let columns = rows[0].indices.map { index in
      rows.map { $0[index] }
    }

    async let vertical = calculate(columns, smudges: smudges)
    async let horizontal = calculate(rows, smudges: smudges)

    return await vertical + horizontal * 100
  }

  @Sendable private func calculate(_ array: [[Character]], smudges: Int) async -> Int {
    return await withTaskGroup(of: Optional<Int>.self) { group in
      for index in array.indices.dropFirst() {
        group.addTask {
          calculate(array, mirror: index, smudges: smudges)
        }
      }

      return await group.first { mirror in
        mirror != nil
      }?.flatMap { $0 } ?? 0
    }
  }

  @Sendable private func calculate(_ array: [[Character]], mirror: Int, smudges: Int) -> Int? {
    var l = mirror - 1
    var r = mirror
    var smudges = smudges
    while l >= 0, r < array.count {
      guard array[l].equals(array[r], smudges: &smudges) else { return nil }
      l -= 1
      r += 1
    }
    guard smudges == 0 else { return nil }
    return mirror
  }

  private let data: String
}

extension Array where Element: Equatable {
  fileprivate func equals(_ rhs: Self, smudges: inout Int) -> Bool {
    let lhs = self
    guard lhs.count == rhs.count else { return false }
    for (lhs, rhs) in zip(lhs, rhs) where lhs != rhs {
      guard smudges > 0 else { return false }
      smudges -= 1
    }
    return true
  }
}
