import Foundation

struct Day07: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    struct Line {
      let hand: Hand
      let bid: UInt

      init<S: StringProtocol>(_ line: S) {
        let space = line.firstIndex(of: " ")!
        hand = Hand(line.prefix(upTo: space))
        bid = UInt(String(line.suffix(from: line.index(after: space)))) ?? 0
      }
    }
    let lines = data.split(separator: "\n").map(Line.init)

    return
      lines
      .sorted(using: KeyPathComparator(\.hand))
      .enumerated()
      .map { index, line in
        return UInt(index + 1) * line.bid
      }
      .reduce(0, +)
  }

  private let data: String
}

private struct Hand: Comparable, CustomStringConvertible {
  init(_ labels: [Label]) {
    self.labels = labels
    self.combo = Combo(labels)
  }

  init<S: StringProtocol>(_ s: S) {
    self.init(s.map(Label.init))
  }

  static func < (lhs: Hand, rhs: Hand) -> Bool {
    guard lhs.combo == rhs.combo else {
      return lhs.combo < rhs.combo
    }
    return lhs.labels.lexicographicallyPrecedes(rhs.labels)
  }

  var description: String {
    "\(labels.map(\.description).joined(separator: "")) \(combo)"
  }

  private let labels: [Label]
  private let combo: Combo
}
//32T3K two
//T55J5 three
//KTJJT doubleTwo
//KK677 doubleTwo
//QQQJA three

private enum Combo: Comparable {
  case one
  case two
  case doubleTwo
  case three
  case threeTwo
  case four
  case five

  init(_ labels: [Label]) {
    let counts = Dictionary(grouping: labels, by: \.rank).values.map(\.count).sorted()
    switch counts {
    case [5]: self = .five
    case [1, 4]: self = .four
    case [2, 3]: self = .threeTwo
    case [1, 1, 3]: self = .three
    case [1, 2, 2]: self = .doubleTwo
    case [1, 1, 1, 2]: self = .two
    default: self = .one
    }
  }
}

private struct Label: Comparable, Hashable, CustomStringConvertible {
  init(_ character: Character) {
    switch character {
    case "2"..."9": rank = character.wholeNumberValue ?? 0
    case "T": rank = 10
    case "J": rank = 11
    case "Q": rank = 12
    case "K": rank = 13
    case "A": rank = 14
    default: rank = 0
    }
  }

  static func < (lhs: Label, rhs: Label) -> Bool {
    lhs.rank < rhs.rank
  }

  var description: String {
    switch rank {
    case 2...9: return "\(rank)"
    case 10: return "T"
    case 11: return "J"
    case 12: return "Q"
    case 13: return "K"
    case 14: return "A"
    default: return "?"
    }
  }

  var rank: Int
}
