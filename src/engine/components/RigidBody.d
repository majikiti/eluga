module engine.components.RigidBody;

import engine;

Vec2 g = Vec2(0, 9.81);

// Need components: Transform
class RigidBody: Component {
  Vec2 v, a, F, gF;
  real m; // 質量
  real e; // 反発係数
  real mu; // 摩擦係数

  this(real m, real e = 1, real mu = 1, Vec2 v0 = Vec2(0, 0)) {
    this.v = v0;
    this.gF = m * g;
    this.m = m;
    this.e = e;
    this.mu = mu;
  }

  void addForce(Vec2 F) {
    this.F = F;
  }

  // 反発(引数は入射ベクトルと壁の衝突かの判定)
  void repulsion(Vec2 inForce, bool isWall = false) {
    auto opeVect = isWall
      ? Vec2(-1.0L * e, 1.0L / mu)
      : Vec2(1.0L / mu, -1.0L * e);
    addForce(inForce * opeVect);
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
