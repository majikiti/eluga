module engine.components.RigidBody;

import engine;

Vec2 g = Vec2(0, 9.81);

// Need components: Transform
class RigidBody: Component {
  Vec2 v;
  Vec2 a;
  real m;
  // 反発係数
  real e;
  // 摩擦係数
  real mu;

  private Vec2 F;
  private Vec2 gF; // 重力のベクトル

  this(real m, real e = 1.0L, real mu = 1.0L, Vec2 v0 = Vec2(0, 0)) {
    this.m = m;
    gF = new Vec2(0, m * g);
    this.v = v0;
  }

  void addForce(Vec2 F) {
    this.F = F;
  }

  // 反発(引数は入射ベクトルと壁の衝突かの判定)
  void repulsion(Vec2 inForce, bool iswall = false) {
    Vec2 opeVect;
    if(iswall){
      opeVect = new Vec2([-1.0L * e, 1.0L / mu]);
    }else{
      opeVect = new Vec2([1.0L / mu, -1.0L * e]);
    }
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
