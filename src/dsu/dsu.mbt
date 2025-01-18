///|
pub fn hello() -> String {
  "Hello, world "
}

///|
pub struct Dsu {
  n : Int
  parent_or_size : Array[Int]
} derive(Show)

///|
pub fn Dsu::new(n : Int) -> Dsu {
  Dsu::{ n, parent_or_size: Array::make(n, -1) }
}

///|
fn check_bounds(self : Dsu, a : Int) -> Unit {
  if 0 <= a && a <= self.n {
    return ()
  }
  println("Out of bounds in Dsu");
  panic()
}

///|
pub fn leader(self : Dsu, a : Int) -> Int {
  self.check_bounds(a)
  if self.parent_or_size[a] < 0 {
    a
  } else {
    self.parent_or_size[a] = self.leader(self.parent_or_size[a])
    self.parent_or_size[a]
  }
}

///|
pub fn merge(self : Dsu, a : Int, b : Int) -> Int {
  self.check_bounds(a)
  self.check_bounds(b)
  let mut x = self.leader(a)
  let mut y = self.leader(b)
  if x == y {
    return x
  }
  if -self.parent_or_size[x] < -self.parent_or_size[y] {
    let temp = y
    x = temp
    y = x
  }
  self.parent_or_size[x] += self.parent_or_size[y]
  self.parent_or_size[y] = x
  return x
}

///|
pub fn same(self : Dsu, a : Int, b : Int) -> Bool {
  self.check_bounds(a)
  self.check_bounds(b)
  self.leader(a) == self.leader(b)
}

///|
pub fn size(self : Dsu, a : Int) -> Int {
  self.check_bounds(a)
  return -self.parent_or_size[self.leader(a)]
}

///|
pub fn groups(self : Dsu) -> Array[Array[Int]] {
  let leader_buf : Array[Int] = Array::make(self.n, 0)
  let group_size : Array[Int] = Array::make(self.n, 0)
  for i = 0; i < self.n; i = i + 1 {
    leader_buf[i] = self.leader(i)
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
  result.filter(fn(x) { x.is_empty() == false })
}
