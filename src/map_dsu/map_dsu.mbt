///|
pub fn new[V]() -> T[V] {
  { map: Map::new(), elements: [], parent_or_size: [] }
}

///|
fn get_id[V : Hash + Eq](self : T[V], a : V) -> Int {
  match self.map.get(a) {
    Some(a) => a
    None => {
      let sz = self.map.size()
      self.map.set(a, sz)
      self.elements.push(a)
      self.parent_or_size.push(-1)
      sz
    }
  }
}

///|
fn leader_id[V](self : T[V], a : Int) -> Int {
  if self.parent_or_size[a] < 0 {
    a
  } else {
    self.parent_or_size[a] = self.leader_id(self.parent_or_size[a])
    self.parent_or_size[a]
  }
}

///|
pub fn leader[V : Hash + Eq](self : T[V], a : V) -> V {
  let a = self.get_id(a)
  let leader_id = self.leader_id(a)
  self.elements[leader_id]
}

///|
fn merge_nocheck[V](self : T[V], a : Int, b : Int) -> Int {
  let mut x = self.leader_id(a)
  let mut y = self.leader_id(b)
  if x == y {
    x
  } else {
    if -self.parent_or_size[x] < -self.parent_or_size[y] {
      let temp = y
      x = temp
      y = x
    }
    self.parent_or_size[x] += self.parent_or_size[y]
    self.parent_or_size[y] = x
    x
  }
}

///|
pub fn merge[V : Hash + Eq](self : T[V], a : V, b : V) -> V {
  let a = self.get_id(a)
  let b = self.get_id(b)
  self.elements[self.merge_nocheck(a, b)]
}

///|
pub fn same[V : Hash + Eq](self : T[V], a : V, b : V) -> Bool {
  let a = self.get_id(a)
  let b = self.get_id(b)
  self.leader_id(a) == self.leader_id(b)
}

///|
pub fn size[V : Hash + Eq](self : T[V], a : V) -> Int {
  let a = self.get_id(a)
  -self.parent_or_size[self.leader_id(a)]
}

///|
pub fn groups[V : Hash + Eq](self : T[V]) -> Array[Array[V]] {
  let n = self.map.size()
  let leader_buf : Array[Int] = Array::make(n, 0)
  let group_size : Array[Int] = Array::make(n, 0)
  for i = 0; i < n; i = i + 1 {
    leader_buf[i] = self.leader_id(i)
    group_size[leader_buf[i]] += 1
  }
  let result : Array[Array[Int]] = Array::makei(n, fn(_) { Array::make(0, 0) })
  for i = 0; i < n; i = i + 1 {
    result[i].reserve_capacity(group_size[i])
  }
  for i = 0; i < n; i = i + 1 {
    result[leader_buf[i]].push(i)
  }
  result
  .filter(fn(x) { not(x.is_empty()) })
  .map(fn(a) { a.map(fn(x) { self.elements[x] }) })
}
