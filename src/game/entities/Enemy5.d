module game.entities.Enemy5;

import engine;
import game;
import std.algorithm;

class Enemy5: Enemy {
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "enem1.png";
  Transform hero;
  Timer atkTmr;

  this(const Vec2 initPos = Vec2(0, 0)){
    super(initPos);
    status = gm.getStatus(this);
  }

  override void setup() {
    super.setup();
    hero = gm.hero.component!Transform;
    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(1, 1, 10));
    atkTmr = new Timer;
  }

  override void loop() {
    super.loop();
    auto tform = component!Transform;
    if(atkTmr.cur > 2000){
      register(new Missile(Missile.Type.Normal, hero.pos-tform.pos, tform.pos + Vec2(0,10), Missile.Target.Hero));
      atkTmr.reset;
    }
  }

  override void collide(GameObject go){
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
