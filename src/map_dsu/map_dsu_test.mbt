test "@map_dsu.same/basic" {
  let d = @map_dsu.new()
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

test "@map_dsu.same/out_of_bounds" {
  let d = @map_dsu.new()
  // Accessing element outside of DSU size
  inspect!(d.same(3, 0), content="false")
}

test "@map_dsu.same/negative_index" {
  let d = @map_dsu.new()
  // Accessing negative index
  inspect!(d.same(3, 0), content="false")
}

test "@map_dsu.new" {
  // Test the creation of a DSU structure with size 0
  let dsu : @map_dsu.T[Unit] = @map_dsu.new()
  let _ = inspect!(dsu.map, content="{}")
  let _ = inspect!(dsu.elements, content="[]")
  let _ = inspect!(dsu.parent_or_size, content="[]")

}

test "@map_dsu.leader" {
  // Test the leader function for a DSU with size 5
  let dsu = @map_dsu.new()
  inspect!(dsu.leader(0), content="0")
  inspect!(dsu.leader(4), content="4")
}

test "@map_dsu.merge" {
  // Test merging two sets in the DSU
  let dsu = @map_dsu.new()
  let _ = dsu.merge(0, 1)
  let _ = inspect!(dsu.leader(0), content="0")
  let _ = inspect!(dsu.leader(1), content="0")
  let _ = dsu.merge(1, 2)
  inspect!(dsu.leader(2), content="0")
}
