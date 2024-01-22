module game.effects.Effect;

import std;
import game;
import engine;

class Effect : GameObject {
  enum Motion {
    Follow,
    Retention,
  }

  SpriteRenderer sr;
  Transform tf;
  string imdir() => "effect/smoke.png";

  // dratio: 公比
  real dratio, scale;
  protected ubyte tp;

  this(real dratio = 1.1, real scale = 0.001) {
    tf = register(new Transform(component!Transform.Org.Spawn, component!Transform.Zoom.Center));
    auto imga = new ImageAsset(imdir);
    sr = register(new SpriteRenderer(imga));

    this.dratio = dratio;

    this.scale = scale;
    tf.scale = Vec2(scale, scale);

    this.tp = ubyte.max;

    layer = -50;
  }

  override void loop() {
    tf.scale *= dratio;
    tp-=3;
    sr.opac(tp);
    if(tp == 0) destroy;
  }
}
