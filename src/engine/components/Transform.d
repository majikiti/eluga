module engine.components.Transform;

import engine;

class Transform: Component {
  Vec2 pos;
  real rot;
  Vec2 scale;

  auto translate(Vec2 add) => pos += add;
}
