///|
pub struct T[V] {
  map : Map[V, Int]
  elements : Array[V]
  parent_or_size : Array[Int]
}

///|
impl[V : Show + Hash + Eq] Show for T[V] with output(self, logger) {
  logger.write_string(self.groups().to_string())
}
