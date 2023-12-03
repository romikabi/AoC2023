struct Day03: AdventDay {
  init(data: String) {
    grid = data.split(separator: "\n").map { $0.map(Node.init) }
  }

  func part1() -> Any {
    var sum = 0
    for i in grid.indices {
      var number = 0
      var counts = false
      for j in grid[i].indices {
        switch grid[i][j] {
        case .gap, .symbol:
          if counts || grid[i][j] == .symbol {
            sum += number
          }
          number = 0
          counts = false
        case let .digit(digit):
          number = number * 10 + digit
          counts = counts || hasNeighboringSymbol(i: i, j: j)
        }
      }
      if counts {
        sum += number
      }
      number = 0
      counts = false
    }
    return sum
  }

  private func hasNeighboringSymbol(i: Int, j: Int) -> Bool {
    for x in (i - 1)...(i + 1) where grid.indices.contains(x) {
      for y in (j - 1)...(j + 1) where grid.indices.contains(y) {
        if grid[x][y] == .symbol {
          return true
        }
      }
    }
    return false
  }

  private enum Node: Equatable {
    case gap
    case symbol
    case digit(Int)

    init(_ character: Character) {
      if character == "." {
        self = .gap
      } else if let digit = character.wholeNumberValue {
        self = .digit(digit)
      } else {
        self = .symbol
      }
    }
  }

  private let grid: [[Node]]
}
