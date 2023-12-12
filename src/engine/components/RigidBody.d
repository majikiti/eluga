module engine.components.RigidBody;

import engine;

class RigidBody: Component {
  Vec2 v;
  Vec2 a;
  real m;

  void addForce(Vec2 F) {
    a += F / m;
  }
}
