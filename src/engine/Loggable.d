module engine.Loggable;

import std.stdio;

class Loggable {
  void dbg(A...)(A a) {
    writeln("[DEBUG] ", a);
  }

  void log(A...)(A a) {
    writeln("[LOG] ", a);
  }

  void warn(A...)(A a) {
    stderr.writeln("[WARN] ", a);
  }

  void err(A...)(A a) {
    stderr.writeln("[ERR] ", a);
  }
}
