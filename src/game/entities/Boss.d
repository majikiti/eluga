module game.entities.Boss;

import std.algorithm;
import engine;
import game;

class Boss: Enemy {
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "flyingenem.png";
  Transform hero;
  Timer flytmr;
  Timer atkTmr;
  bool flying;
  real starTime = 200, timer = 0;

  this(const Vec2 initPos = Vec2(0, 0)){
    super(initPos);
    status = gm.getStatus(this);
    flying = false;
  }

  override void setup() {
    super.setup();
    tform.scale = Vec2(0.4, 0.4);
    hero = gm.hero.component!Transform;
    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(3, 1, 10));
    flytmr = new Timer;
    atkTmr = new Timer;
  }

  override void loop() {
    super.loop();
    auto rb = component!RigidBody;
    auto rend = component!SpriteRenderer;
    if(atkTmr.cur > 500){
      register(new Missile(Missile.Type.CCCP, (hero.pos-tform.pos).unit*50, tform.pos + Vec2(0,50), Missile.Target.Hero));
      atkTmr.reset;
    }
    if(!flying && 500 < flytmr.cur && flytmr.cur < 750) {
      rb.g = Vec2(0, -9.81*3);
      flying = true;
    }
    if(flying && flytmr.cur >= 750){
      rb.g = Vec2(0, 9.81);
      flying = false;
    }
    if(status.star && starTime > timer){
      rend.active = !rend.active;
      timer += dur;
    }
    else timer = 0, status.star = false, rend.active = true;
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    auto tform = component!Transform;
    if(go.getTag("Ground")){
      if(hero) rb.v = Vec2(max(min(2,0.02*(hero.pos.x - tform.pos.x)),-1.5),-2);
      if(flying){
        rb.g = Vec2(0, 9.81);
        flying = false;
      }
      flytmr.reset;
    }
    if(go.getTag("Hero") && !gm.heroStatus.star){
      if(gm.heroStatus){
        gm.heroStatus.star = true;
        gm.heroStatus.life -= 1;
      }
    }
    if(!status.star && go.getTag("Missile")) {
      register(new Damage);
      status.star = true;
    }
  }
}
