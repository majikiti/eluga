module utils;

import std;
import sdl;

alias Pair(T, U = T) = Tuple!(T, "a", U, "b");

auto rect(X, Y, W, H)(X x = 0, Y y = 0, W w = 0, H h = 0) =>
  new SDL_Rect(cast(int)x, cast(int)y, cast(int)w, cast(int)h);
