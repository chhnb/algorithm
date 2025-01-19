///|
pub fn new(n : Int) -> T {
  { n, parent_or_size: Array::make(n, -1) }
}

///|
fn check_bounds(self : T, a : Int) -> Unit {
  if 0 <= a && a <= self.n {
    ()
  } else {
    println("Out of bounds in DSU")
    panic()
  }
}

///|
fn leader_nocheck(self : T, a : Int) -> Int {
  if self.parent_or_size[a] < 0 {
    a
  } else {
    self.parent_or_size[a] = self.leader_nocheck(self.parent_or_size[a])
    self.parent_or_size[a]
  }
}

///|
pub fn leader(self : T, a : Int) -> Int {
  self.check_bounds(a)
  if self.parent_or_size[a] < 0 {
    a
  } else {
    self.parent_or_size[a] = self.leader(self.parent_or_size[a])
    self.parent_or_size[a]
  }
}

///|
fn merge_nocheck(self : T, a : Int, b : Int) -> Int {
  let mut x = self.leader_nocheck(a)
  let mut y = self.leader_nocheck(b)
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
pub fn merge(self : T, a : Int, b : Int) -> Int {
  self.check_bounds(a)
  self.check_bounds(b)
  self.merge_nocheck(a, b)
}

///|
pub fn same(self : T, a : Int, b : Int) -> Bool {
  self.check_bounds(a)
  self.check_bounds(b)
  self.leader_nocheck(a) == self.leader_nocheck(b)
}

///|
pub fn size(self : T, a : Int) -> Int {
  self.check_bounds(a)
  -self.parent_or_size[self.leader_nocheck(a)]
}

///|
pub fn groups(self : T) -> Array[Array[Int]] {
  let leader_buf : Array[Int] = Array::make(self.n, 0)
  let group_size : Array[Int] = Array::make(self.n, 0)
  for i = 0; i < self.n; i = i + 1 {
    leader_buf[i] = self.leader_nocheck(i)
    group_size[leader_buf[i]] += 1
  }
  let result : Array[Array[Int]] = Array::makei(self.n, fn(_) {
    Array::make(0, 0)
  })
  for i = 0; i < self.n; i = i + 1 {
    result[i].reserve_capacity(group_size[i])
  }
  for i = 0; i < self.n; i = i + 1 {
    result[leader_buf[i]].push(i)
  }
  result.filter(fn(x) { not(x.is_empty()) })
}
