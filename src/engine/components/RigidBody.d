module engine.components.RigidBody;

import engine;
import utils;

Vec2 g0 = Vec2(0, 9.81);

// Need components: Transform
class RigidBody: Component {
  Vec2 v, a, F, gF;
  real m; // 質量
  real e; // 反発係数
  real mu; // 摩擦係数

  Vec2 g(Vec2 _g) {
    gF = m * _g;
    return _g;
  }

  this(real m, real e = 1, real mu = 1, Vec2 v0 = Vec2(0, 0)) {
    this.m = m;
    this.g = g0;
    this.e = e;
    this.mu = mu;
    this.v = v0;
  }

  void addForce(Vec2 F) {
    this.F = F;
  }

  // 反発(引数はx,y方向反転のbool値と壁の衝突かの判定)
  void repulsion(Pair!bool touchDir, bool isWall = false) {
    auto touchVec = Vec2(touchDir.a ? -1 : 0, touchDir.b ? -1 : 0);
    auto repVec = touchVec * this.v * m * e;
    addForce(repVec);
  }

  override void loop() {
    auto tform = go.component!Transform;
    F += gF;
    a += F / m;
    F = Vec2(0, 0);
    v += a*go.dur/256;
    tform.pos += v*go.dur;
  }
}
