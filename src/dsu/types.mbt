///|
pub struct T {
  n : Int
  parent_or_size : Array[Int]
}

///|
pub impl Show for T with output(self, logger) {
  logger.write_string(self.groups().to_string())
}
