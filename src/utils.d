module utils;

import std;

alias Pair(T, U = T) = Tuple!(T, "a", U, "b");
