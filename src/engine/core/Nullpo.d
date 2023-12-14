module engine.core.Nullpo;

import std.exception;

class Nullpo: Exception {
  this(string msg, string file = __FILE__, size_t line = __LINE__) {
    super(msg, file, line);
  }
}
