# Algorithm

[![CI](https://github.com/chhnb/algorithm/actions/workflows/ci.yml/badge.svg)](https://github.com/chhnb/algorithm/actions/workflows/ci.yml)

Competitive programming algorithm templates for MoonBit.

## Usage

### DSU

See [Disjoint-set data structure](https://en.wikipedia.org/wiki/Disjoint-set_data_structure).

```moonbit
fn main {
  let dsu = @dsu.new(10)

  let _ = dsu.merge(1, 2)
  let _ = dsu.merge(3, 4)

  println(dsu.groups()) // [[0], [1, 2], [3, 4], [5], [6], [7], [8], [9]]
  println(dsu.same(1, 2)) // true
  println(dsu.same(3, 1)) // false
  println(dsu.leader(2)) // 1

  let root = dsu.merge(1, 3); // 1
  println(root); // 1
  println(dsu.size(root)) // 4
}
```

## License

Apache-2.0 license © 2025 [chhnb](https://github.com/chhnb)
