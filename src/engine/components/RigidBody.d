module engine.components.RigidBody;

import std;
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

  private bool objectsConflict(Vec2 pos1, GameObject obj2) {
    Vec2 pos2 = obj2.component!Transform.worldPos;
    Vec2 size1 = go.component!BoxCollider.worldScale;
    Vec2 size2 = obj2.component!BoxCollider.worldScale;
    Vec2 center1 = pos1 + size1/2;
    Vec2 center2 = pos2 + size2/2;
    
    bool hFlag = abs(center1.y - center2.y) < (size1.y + size2.y)/2.0;
    bool wFlag = abs(center1.x - center2.x) < (size1.x + size2.x)/2.0;

    return hFlag && wFlag;
  }

  // 解析: Kang
  // 計算量 \(^o^)/  最悪計算量実質的にO(N^4)
  private void update(){
    auto tform = go.component!Transform;
    Vec2 resV = v, initV; // resVが我が速度
    real dur = go.dur, time = dur; // ぢれいしょん
    while(resV.size > 0 && dur > 0){
      initV = resV;
      time = dur;
      if(go.has!BoxCollider){ // ぼっこ持ってる
        if(!go.component!BoxCollider.isTrigger){ // TRIGされていない
          auto gos = go.ctx.root.everyone.filter!(e => e.has!BoxCollider && e.has!Transform).array; // ぼっこととらふぉ持ってる配列
          Vec2 afterPos; // 
          foreach(i, p; gos) {
            if(p == go || p.component!BoxCollider.isTrigger) continue; // 除外すべきタイミング
            afterPos = tform.worldPos + resV*time; // 事後の位置ベクトル
            foreach(j, q; gos[i..$]) {
              if(q == go || q.component!BoxCollider.isTrigger) continue;
              if(objectsConflict(afterPos,q)){ // 事後位置とqの衝突
                real ok = 0, ng = time, mid; // どうやら衝突しない事後位置を探すにぶたん処理みたい
                while(abs(ok - ng) > 0.1){
                  mid = (ok + ng) / 2.0;
                  afterPos = tform.worldPos + resV * mid;
                  if(objectsConflict(afterPos, q)) {
                    ng = mid;
                  }
                  else ok = mid;
                }
                time = ok;
                resV = initV;
                resV.x /= mu;
              }
              if(objectsConflict(tform.worldPos + Vec2(resV.x,0) * (time + 0.1), q)) resV.x = 0; // 微小振動の削除
              if(objectsConflict(tform.worldPos + Vec2(0,resV.y) * (time + 0.1), q)) resV.y = 0; // ^のy編
            }
          }
        }
      }
      tform.pos += resV * time;
      dur -= time;
    }
    v = resV;
  }

  override void loop() {
    auto tform = go.component!Transform;
    a = (F + gF) / m;
    dbg(gF / m);
    F = Vec2(0, 0);
    v += a * go.dur/256;
    update();
  }

 debug:
  bool debugFrame = false;

  override void debugLoop() {
    if(!debugFrame) return;
    Vec2 size1 = go.component!BoxCollider.worldScale;
    auto pos = go.component!Transform.campos + size1 / 2;
    color(255, 241, 0);
    line(pos, pos + v*50);
    color(255, 0, 0);
    line(pos, pos + Vec2(v.x, 0)*50);
    color(0, 0, 255);
    line(pos, pos + Vec2(0, v.y)*50);
  }
}
