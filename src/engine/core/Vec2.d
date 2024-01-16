module engine.core.Vec2;

import std.math;

alias Vec2 = _Vec2!real;
alias Vec2fixed = _Vec2!long;

struct _Vec2(T) {
  T[2] pos = [0, 0];

  this(U)(U[] pos) {
    this.pos = cast(T[])pos;
  }

  this(T x, T y) {
    this([x, y]);
  }

  auto ref x() => pos[0];
  auto ref y() => pos[1];
  auto _x() const => pos[0];
  auto _y() const => pos[1];

  real size() const => sqrt(cast(real)(_x ^^ 2 + _y ^^ 2));
  auto unit() const => Vec2(pos) / size;

  auto v() const => typeof(this)(0, _y);
  auto h() const => typeof(this)(_x, 0);

  // くるくる
  auto rotdeg(real degree) {
    Vec2 retval;
    auto rad = degree * PI / 180;
    retval.x = x*cos(rad) - y*sin(rad);
    retval.y = x*sin(rad) + y*cos(rad);
    return retval;
  }

  auto rot(real radian) {
    Vec2 retval;
    retval.x = x*cos(radian) - y*sin(radian);
    retval.y = x*sin(radian) + y*cos(radian);
    return retval;
  }

  // op

  auto opUnary(string op)() const =>
    typeof(this)(mixin(op ~ ` pos[]`));

  auto opBinary(string op, T: Vec2)(T rhs) const {
    typeof(pos) v = mixin(`pos[] ` ~ op ~ ` rhs.pos[]`);
    return typeof(this)(v);
  }

  auto opBinary(string op, T)(T rhs) const {
    typeof(pos) v = mixin(`pos[] ` ~ op ~ ` rhs`);
    return typeof(this)(v);
  }

  auto opBinaryRight(string op, T)(T lhs) => opBinary!(op)(lhs);

  auto opOpAssign(string op, T: Vec2)(T rhs) {
    mixin(`pos[] ` ~ op ~ `= rhs.pos[];`);
    return this;
  }

  auto opOpAssign(string op, T)(T rhs) {
    mixin(`pos[] ` ~ op ~ `= rhs;`);
    return this;
  }
}
