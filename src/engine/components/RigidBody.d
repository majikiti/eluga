module engine.components.RigidBody;

import engine;

// Need components: Transform
class RigidBody: Component {
  Vec2 v;
  Vec2 a;
  real m;

  void addForce(Vec2 F) {
    a += F / m;
  }

  override void loop(){
    auto tform = go.component!Transform;
    v += a*go.dur;
    tform.pos += v*go.dur;
  }
}
