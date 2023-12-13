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

    auto hero0 = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void setup() {
    register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
  }

  override void loop() {
    auto tform = component!Transform;
    tform.pos += v*dur;
    if(tform.pos.x < 0) v.x = 1;
    if(tform.pos.x > 100) v.x = -1;
    if(tform.pos.y < 0) v.y = 1;
    if(tform.pos.y > 100) v.y = -1;
    time += dur;
    log(time);
    if(time > 1000){
      time = 0;
      register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
    }
  }
}
