struct Day11: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    var lines = data.split(separator: "\n").map { line in
      line.map { $0 }
    }

    lines = lines.flatMap { line in
      line.contains("#") ? [line] : [line, line]
    }

    for j in lines.first?.indices.reversed() ?? [] {
      if lines.indices.allSatisfy({ i in lines[i][j] != "#" }) {
        for i in lines.indices {
          lines[i].insert(".", at: j)
        }
      }
    }

    let galaxies = lines.indices.flatMap { i in
      lines[i].indices.compactMap { j in
        lines[i][j] == "#" ? (i: i, j: j) : nil
      }
    }

    let distances =
      galaxies
      .permutations(ofCount: 2)
      .map { permutation in
        (permutation.first!, permutation.last!)
      }
      .map { first, second -> Int in
        max(first.i, second.i) - min(first.i, second.i) + max(first.j, second.j)
          - min(first.j, second.j)
      }
    return distances.reduce(0, +) / 2
  }

  private let data: String
}
