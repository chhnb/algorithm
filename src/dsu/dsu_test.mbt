test "@ lib.same/basic" {
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

test "panic @ lib.same/out_of_bounds" {
  let d = @dsu.Dsu::new(3)
  // Accessing element outside of DSU size
  let _ = d.same(3, 0)

}

test "panic @ lib.same/negative_index" {
  let d = @dsu.Dsu::new(3)
  // Accessing negative index
  let _ = d.same(-1, 0)

}
