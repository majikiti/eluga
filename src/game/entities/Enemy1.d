module game.entities.Enemy1;

import engine;
import game;

class Enemy1: Enemy {
  real theta = 0;
  LifeIndicator lifin;
  override string imgdir() => "enem1.png";

  this(const Vec2 initPos = Vec2(0, 0)){
    super(initPos);
  }

  override void eachsetup() {
    lifin = register(new LifeIndicator);
    lifin.getStatus(this.component!Status);
    rigid = register(new RigidBody(1, 1, 10));
  }

  override void eachloop() {
    if(this.component!Status.isDamaged){
      rigid.addForce(Vec2(200,-200));
      this.component!Status.isDamaged = false;
    }
  }
}
