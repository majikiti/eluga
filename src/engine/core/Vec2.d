module engine.core.Vec2;

import core.math;

struct Vec2 {
  real[2] pos = [0, 0];

  this(real[2] pos) {
    this.pos = pos;
  }

  this(real x, real y) {
    this([x, y]);
  }

  auto ref x() => pos[0];
  auto ref y() => pos[1];
  auto _x() const => pos[0];
  auto _y() const => pos[1];

  real size() const => sqrt(_x ^^ 2 + _y ^^ 2);
  Vec2 unit() const => Vec2(pos) / size;

  // op

  auto opUnary(string op)() const =>
    Vec2(mixin(op ~ ` pos[]`));

  auto opBinary(string op, T: Vec2)(T rhs) const {
    typeof(pos) v = mixin(`pos[] ` ~ op ~ ` rhs.pos[]`);
    return Vec2(v);
  }

  auto opBinary(string op, T)(T rhs) const {
    typeof(pos) v = mixin(`pos[] ` ~ op ~ ` rhs`);
    return Vec2(v);
  }

  auto opOpAssign(string op, T: Vec2)(T rhs) {
    mixin(`pos[] ` ~ op ~ `= rhs.pos[];`);
    return this;
  }

  auto opOpAssign(string op, T)(T rhs) {
    mixin(`pos[] ` ~ op ~ `= rhs;`);
    return this;
  }
}
