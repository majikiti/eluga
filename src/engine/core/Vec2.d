module engine.core.Vec2;

struct Vec2 {
  real[2] pos;

  auto ref x() => pos[0];
  auto ref y() => pos[1];

  auto opUnary(string op)() const =>
    Vec2(mixin(op ~ `pos[]`));

  auto opBinary(string op, T: Vec2)(T rhs) const =>
    Vec2(mixin(`pos[]` ~ op ~ `rhs.pos[]`));

  auto opBinary(string op, T)(T rhs) const =>
    Vec2(mixin(`pos[]` ~ op ~ `rhs`));

  auto opOpAssign(string op, T: Vec2)(T rhs) {
    mixin(`pos[]` ~ op ~ `=rhs.pos[];`);
    return this;
  }

  auto opOpAssign(string op, T)(T rhs) {
    mixin(`pos[]` ~ op ~ `=rhs;`);
    return this;
  }
}
