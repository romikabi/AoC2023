struct Day04: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    struct Card {
      let winning: Set<UInt>
      let yours: Set<UInt>

      init<S: StringProtocol>(_ string: S) {
        guard let colon = string.firstIndex(of: ":"),
          let sep = string.firstIndex(of: "|")
        else {
          winning = []
          yours = []
          return
        }

        let info = string.suffix(from: string.index(after: colon))
        winning = Set(
          info
            .prefix(upTo: sep)
            .split(separator: " ")
            .compactMap { UInt($0) }
        )
        yours = Set(
          info
            .suffix(from: string.index(after: sep))
            .split(separator: " ")
            .compactMap { UInt($0) }
        )
      }

      var matches: Int {
        winning.intersection(yours).count
      }

      var score: UInt {
        2 << (matches - 2)
      }
    }

    return
      data
      .split(separator: "\n")
      .map(Card.init)
      .map(\.score)
      .reduce(0, +)
  }

  private let data: String
}
