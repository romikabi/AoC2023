struct Day05: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    let almanac = Almanac(data)

    return almanac.seeds.map { seed -> UInt in
      almanac.maps.reduce(seed) { key, maps -> UInt in
        let map =
          maps.first { map in
            map.source.contains(key)
          } ?? Almanac.Map(source: key..<key + 1, target: key..<key + 1)
        let mapped = map.target[
          map.source.firstIndex(of: key)! - map.source.startIndex + map.target.startIndex]
        return mapped
      }
    }.min() ?? 0
  }

  private let data: String
}

private struct Almanac {
  struct Map {
    let source: Range<UInt>
    let target: Range<UInt>
  }
  let seeds: [UInt]
  let maps: [[Map]]

  init(_ s: String) {
    let splits = s.split(separator: "\n\n")

    seeds = splits[0].split(separator: " ").map(String.init).compactMap(UInt.init)

    func makeMap<S: StringProtocol>(section: S) -> [Map] {
      section.split(separator: "\n").dropFirst()
        .map { line in
          let nums = line.split(separator: " ")
          return (UInt(nums[0]) ?? 0, UInt(nums[1]) ?? 0, UInt(nums[2]) ?? 1)
        }
        .map { s2, s1, l in
          Map(source: s1..<s1 + l, target: s2..<s2 + l)
        }
    }

    maps = splits.dropFirst().map(makeMap)
  }
}
