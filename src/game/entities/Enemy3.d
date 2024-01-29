module game.entities.Enemy3;

import std.algorithm;
import engine;
import game;

class Enemy3: Enemy {
  real theta = 0;
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "enem1.png";
  Transform hero;

  this(const Vec2 initPos = Vec2(0, 0)){
    super(initPos);
    status = gm.getStatus(this);
  }

  override void setup() {
    super.setup();
    hero = gm.hero.component!Transform;
    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(1, 1, 10));
  }

  override void collide(GameObject go){
    if(status.willDead) return; // 死ぬ時ぐらいはそっとしてあげよう
    super.collide(go);
    auto rb = component!RigidBody;

    if(go.getTag("Ground")){
      if(hero) rb.v = Vec2(max(min(2,0.02*(hero.pos.x - tform.pos.x)),-2),-2);
    }
    if(go.getTag("Hero") && !gm.heroStatus.star){
      if(gm.heroStatus){
        gm.heroStatus.star = true;
        gm.heroStatus.life -= 1;
      }
    }
    if(go.getTag("Missile")) {
      register(new Damage);
    }
  }
}
