module game.entities.Enemy1;

import engine;
import game;

class Enemy1: Enemy {
  real theta = 0;
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "enem1.png";

  this(const Vec2 initPos = Vec2(0, 0)){
    super(initPos);
    status = gm.getStatus(this);
  }

  override void setup() {
    super.setup;

    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(1, 1, 10));
  }

  override void loop() {
    super.loop;
    
    if(status.isDamaged){
      rigid.addForce(Vec2(200,-200));
      status.isDamaged = false;
    }
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    if(go.getTag("Missile")) {
      register(new Damage);
      //auto aas = new AudioAsset("damage1.mp3");
      //auto asrc = new AudioSource(aas);
      //asrc.play;
    }

    if(go.getTag("Hero") && !gm.heroStatus.star){
      if(gm.heroStatus){
        gm.heroStatus.star = true;
        gm.heroStatus.life -= 1;
      }
    }
    
    if(go.getTag("Ground") && rb.v.y > -1) rb.v.x = 0;
  }
}
