module engine.components.Transform;

import engine;

class Transform: Component {
  Vec2 pos = Vec2(0,0);
  real rot;
  Vec2 scale;

  auto translate(Vec2 d) => pos += d;
}
