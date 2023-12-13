module game.entities.Hero;

import engine;
import game;

class Hero: GameObject {
  int life;
  int type;
  real time = 0;

  Vec2 v = Vec2(1, 1);

  this() {
    register(new Transform);
    register(new RigidBody);

    auto hero0 = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void setup() {
    register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
    auto rb = component!RigidBody;
    rb.v = v;
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(tform.pos.x < 0) rb.v.x = 1;
    if(tform.pos.x > 100) rb.v.x = -1;
    if(tform.pos.y < 0) rb.v.y = 1;
    if(tform.pos.y > 100) rb.v.y = -1;
    time += dur;
    if(time > 100){
      time = 0;
      register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
    }
  }
}
