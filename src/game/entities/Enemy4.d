module game.entities.Enemy4;

import engine;
import game;
import std.algorithm;

class Enemy4: Enemy {
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "enem1.png";
  Transform player;
  Timer flytmr;
  bool flying;

  this(const Vec2 initPos = Vec2(0, 0),Transform tform){
    super(initPos);
    player = tform;
    status = gm.getStatus(this);
    flying = false;
  }

  override void setup() {
    super.setup();
    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(2, 1, 10));
    flytmr = new Timer;
  }

  override void loop() {
    super.loop();
    auto rb = component!RigidBody;
    if(!flying && 500 < flytmr.cur && flytmr.cur < 1000) {
      rb.g = Vec2(0, -9.81);
      flying = true;
    }
    if(flying && flytmr.cur >= 1000){
      rb.g = Vec2(0, 9.81);
      flying = false;
    }
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    auto tform = component!Transform;
    if(go.getTag("Ground")){
      if(player) rb.v = Vec2(max(min(2,0.02*(player.pos.x - tform.pos.x)),-2),-2);
      if(flying){
        rb.g = Vec2(0, 9.81);
        flying = false;
      }
      flytmr.reset;
    }
    if(go.getTag("Player") && !gm.playerStatus.star){
      if(gm.playerStatus){
        gm.playerStatus.star = true;
        gm.playerStatus.life -= 1;
      }
    }
    if(go.getTag("Missile")) {
      register(new Damage);
    }
  }
}
