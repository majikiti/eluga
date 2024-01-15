module utils;

import std;
import sdl;

alias Pair(T, U = T) = Tuple!(T, "a", U, "b");

auto rect(X, Y, W, H)(X x = 0, Y y = 0, W w = 0, H h = 0) =>
  new SDL_Rect(cast(int)x, cast(int)y, cast(int)w, cast(int)h);

auto at(T)(T v) if(isAssociativeArray!T) {
  struct AA(A) {
    alias K = KeyType!A, V = ValueType!A;
    A a;
    auto opIndex(K i) {
      auto res = i in a;
      static if(isAssociativeArray!V)
        return res ? AA!V(*res) : AA!V.init;
      else
        return res ? *res : V.init;
    }
  }
  return AA!T(v);
}
