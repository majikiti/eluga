module game.effects.WeirdAir;

import std;
import game;
import engine;

class WeirdAir : Effect {
  override string imdir() => "effect/magical.png";
  real angle;
  Timer tmr;

  this(real dratio = 0.999, real scale = 0.15) {
    super(dratio, scale);
    layer = -40;
    tmr = new Timer;
    auto rnd = Random(cast(uint)Clock.currTime.toUnixTime());
    tp = 192;
    angle = 0;
  }

  override void loop() {
    auto rnd = Random(cast(uint)tmr.cur);
    dratio += uniform(-0.001, 0.001, rnd);
    super.loop;
    angle += uniform(-0.3, 0.3, rnd);
    real ampl = uniform(1.0L, 2.0L, rnd);
    tf.pos += Vec2(cos(angle), sin(angle)) * ampl;
  }
}