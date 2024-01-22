module game.entities.Enemy3;

import engine;
import game;
import std.algorithm;

class Enemy3: Enemy {
  real theta = 0;
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "enem1.png";
  Transform player;

  this(const Vec2 initPos = Vec2(0, 0),Transform tform){
    super(initPos);
    player = tform;
    status = gm.getStatus(this);
  }

  override void eachsetup() {
    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(1, 1, 10));
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    auto tform = component!Transform;
    if(go.getTag("Ground")){
      if(player) rb.v = Vec2(max(min(2,0.02*(player.pos.x - tform.pos.x)),-2),-2);
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
