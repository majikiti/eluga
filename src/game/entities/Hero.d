module game.entities.Hero;

import engine;


class Hero: GameObject {
  int life;
  int type;

  Vec2 v = Vec2([5, 5]);

  this() {
    register(new Transform);

    auto hero0 = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void setup() {
  }

  override void loop() {
    auto tform = component!Transform;
    tform.pos += v;
    if(tform.pos.x < 0 || tfrom.pos.x > 100) v.x *= -1;
    if(tform.pos.y < 0 || tform.pos.y > 100) v.y *= -1;

    register(new Missile(Missile.Type.Normal, Vec2([1, 0])));
  }
}
