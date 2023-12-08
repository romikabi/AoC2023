import Foundation

struct Day08: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    let lines = data.split(separator: "\n")
    let sequence = lines.first ?? .init()
    let regex = /(?<key>\w+) = \((?<left>\w+), (?<right>\w+)\)/
    let parsed = lines.dropFirst().compactMap { line in
      line.firstMatch(of: regex)?.output
    }.map { match in
      (match.key, (left: match.left, right: match.right))
    }

    let map = Dictionary(parsed, uniquingKeysWith: { $1 })

    var index = sequence.startIndex
    var place = Substring("AAA")
    var steps = 0
    while place != "ZZZ" {
      steps += 1
      let map = map[place]!
      let next: Substring
      if sequence[index] == "R" {
        next = map.right
      } else {
        next = map.left
      }
      place = next
      index = sequence.index(after: index)
      if index == sequence.endIndex {
        index = sequence.startIndex
      }
    }

    return steps
  }

  private let data: String
}
