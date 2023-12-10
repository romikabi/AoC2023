struct Day10: AdventDay {
  init(data: String) {
    self.data = data
  }

  func part1() -> Any {
    let pipes = data.split(separator: "\n").map { $0.map { $0 } }
    let start = pipes.lazy.indices.flatMap { i in
      pipes[i].lazy.indices.map { j in
        Index(i: i, j: j)
      }
    }.first { index in
      pipes[index.i][index.j] == "S"
    }!

    var steps = 0
    var last = start
    var pipe = start
    repeat {
      let t = pipe
      pipe = connectedPipes(around: pipe, in: pipes).first { $0 != last }!
      last = t
      steps += 1
    } while pipe != start

    return steps / 2
  }

  private let data: String
}

private struct Index: Hashable {
  let i: Int
  let j: Int

  func applyDelta(_ delta: Delta) -> Index {
    switch delta {
    case .i(let di):
      return Index(i: i + di, j: j)
    case .j(let dj):
      return Index(i: i, j: j + dj)
    }
  }
}

private enum Delta: Hashable {
  case i(Int)
  case j(Int)
}

private func connectedPipes(around index: Index, in pipes: [[Character]]) -> [Index] {
  guard let tile = tile(at: index, in: pipes) else { return [] }
  return connections(tile: tile).map(index.applyDelta).filter {
    connected($0, index, in: pipes)
  }
}

private func connected(_ lhs: Index, _ rhs: Index, in pipes: [[Character]]) -> Bool {
  guard let l = tile(at: lhs, in: pipes),
    let r = tile(at: rhs, in: pipes)
  else { return false }
  return connections(tile: l).map(lhs.applyDelta).contains(rhs)
    && connections(tile: r).map(rhs.applyDelta).contains(lhs)
}

private func connections(tile: Character) -> Set<Delta> {
  switch tile {
  case "-": return [.j(-1), .j(1)]
  case "|": return [.i(-1), .i(1)]
  case "F": return [.j(1), .i(1)]
  case "J": return [.j(-1), .i(-1)]
  case "L": return [.j(1), .i(-1)]
  case "7": return [.j(-1), .i(1)]
  case "S": return [.i(-1), .i(1), .j(-1), .j(1)]
  default: return []
  }
}

private func tile(at index: Index, in pipes: [[Character]]) -> Character? {
  guard pipes.indices.contains(index.i), pipes[index.i].indices.contains(index.j) else {
    return nil
  }
  return pipes[index.i][index.j]
}
