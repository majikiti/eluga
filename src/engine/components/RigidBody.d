module engine.components.RigidBody;

import engine;

Vec2 g = [0, 9.81];

// Need components: Transform
class RigidBody: Component {
  Vec2 v;
  Vec2 a;
  real m;

  this() {
    a = g;
  }

  void addForce(Vec2 F) {
    a += F / m;
  }

  override void loop(){
    auto tform = go.component!Transform;
    v += a*go.dur/256;
    tform.pos += v*go.dur;
  }
}
