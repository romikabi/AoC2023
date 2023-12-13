struct Day13: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() async -> Any {
    @Sendable func calculate(_ pattern: Substring) async -> Int {
      let rows = pattern.split(separator: "\n").map(Array.init)
      let columns = rows[0].indices.map { index in
        rows.map { $0[index] }
      }

      @Sendable func calculate(_ array: [[Character]]) async -> Int {
        @Sendable func calculate(_ array: [[Character]], mirror: Int) -> Int? {
          var l = mirror - 1
          var r = mirror
          while l >= 0, r < array.count {
            guard array[l] == array[r] else { return nil }
            l -= 1
            r += 1
          }
          return mirror
        }

        return await withTaskGroup(of: Optional<Int>.self) { group in
          for index in array.indices.dropFirst() {
            group.addTask {
              calculate(array, mirror: index)
            }
          }

          return await group.first { mirror in
            mirror != nil
          }?.flatMap { $0 } ?? 0
        }
      }

      async let vertical = calculate(columns)

      async let horizontal = calculate(rows)

      return await vertical + horizontal * 100
    }

    let patterns = data.split(separator: "\n\n")

    return await withTaskGroup(of: Int.self) { group in
      for pattern in patterns {
        group.addTask {
          return await calculate(pattern)
        }
      }

      return await group.reduce(0, +)
    }
  }

  private let data: String
}
