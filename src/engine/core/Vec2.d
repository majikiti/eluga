module engine.core.Vec2;

import std;

alias Vec2 = _Vec2!real;
alias Vec2fixed = _Vec2!long;

struct _Vec2(T) {
  alias This = _Vec2!T;

  T[2] pos = [0, 0];

  this(U)(U[] pos) {
    this.pos = cast(T[])pos;
  }

  this(T x, T y) {
    this([x, y]);
  }

  auto ref x() inout => pos[0];
  auto ref y() inout => pos[1];

  real size() inout => sqrt(cast(real)(x ^^ 2 + y ^^ 2));
  auto unit() inout => Vec2(pos) / size;

  auto v() inout => This(0, y);
  auto h() inout => This(x, 0);

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

  auto absVec() => Vec2(abs(x), abs(y));

  // op

  auto opUnary(string op)() const => This(mixin(op ~ ` pos[]`));

  auto opBinary(string op, T: Vec2)(T rhs) const {
    typeof(pos) v = mixin(`pos[] ` ~ op ~ ` rhs.pos[]`);
    return This(v);
  }

  auto opBinary(string op, T)(T rhs) const {
    typeof(pos) v = mixin(`pos[] ` ~ op ~ ` rhs`);
    return This(v);
  }

  auto opBinaryRight(string op, T)(T lhs) const => opBinary!(op)(lhs);

  auto opOpAssign(string op, T: Vec2)(T rhs) {
    mixin(`pos[] ` ~ op ~ `= rhs.pos[];`);
    return this;
  }

  auto opOpAssign(string op, T)(T rhs) {
    mixin(`pos[] ` ~ op ~ `= rhs;`);
    return this;
  }

  auto toString() const => "(" ~ x.to!string ~ ", " ~ y.to!string ~ ")";
}
