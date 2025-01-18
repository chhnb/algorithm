test "@dsu.same/basic" {
  let d = @dsu.Dsu::new(5)
  // Initially all elements are in their own groups
  inspect!(d.same(0, 0), content="true")
  inspect!(d.same(0, 1), content="false")

  // After merging elements should be in same group
  let _ = d.merge(0, 1)
  inspect!(d.same(0, 1), content="true")

  // Transitive property: if 0-1 and 1-2 are merged, 0-2 should be in same group
  let _ = d.merge(1, 2)
  inspect!(d.same(0, 2), content="true")
}

test "panic @dsu.same/out_of_bounds" {
  let d = @dsu.Dsu::new(3)
  // Accessing element outside of DSU size
  let _ = d.same(3, 0)

}

test "panic @dsu.same/negative_index" {
  let d = @dsu.Dsu::new(3)
  // Accessing negative index
  let _ = d.same(-1, 0)

}
test "@chh/algorithm/dsu.Dsu::new" {
  // Test the creation of a DSU structure with size 5
  let dsu = @chh/algorithm/dsu.Dsu::new(5)
  let _ = inspect!(dsu.n, content="5")
  let _ = inspect!(dsu.parent_or_size, content="[-1, -1, -1, -1, -1]")

}

test "@chh/algorithm/dsu.Dsu::leader" {
  // Test the leader function for a DSU with size 5
  let dsu = @chh/algorithm/dsu.Dsu::new(5)
  inspect!(dsu.leader(0), content="0")
  inspect!(dsu.leader(4), content="4")
}

test "panic @chh/algorithm/dsu.Dsu::leader/out_of_bounds" {
  // Test out of bounds check for leader function
  let dsu = @chh/algorithm/dsu.Dsu::new(5)
  ignore(dsu.leader(6))
}

test "@chh/algorithm/dsu.Dsu::merge" {
  // Test merging two sets in the DSU
  let dsu = @chh/algorithm/dsu.Dsu::new(5)
  let _ = dsu.merge(0, 1)
  let _ = inspect!(dsu.leader(0), content="0")
  let _ = inspect!(dsu.leader(1), content="0")
  let _ = dsu.merge(1, 2)
  inspect!(dsu.leader(2), content="0")
}

test "panic @chh/algorithm/dsu.Dsu::merge_out_of_bounds" {
  // Test out of bounds check for merge function
  let dsu = @chh/algorithm/dsu.Dsu::new(5)
  ignore(dsu.merge(4, 6))
}