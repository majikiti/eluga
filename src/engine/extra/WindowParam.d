module engine.extra.WindowParam;

import std;
import engine;

class WindowParam: GameObject {
  Vec2 size() => ctx.windowSize;
}