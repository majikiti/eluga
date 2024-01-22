module game.effects.Damage;

import std;
import game;
import engine;

class Damage : Effect {
  override string imdir() => "effect/damage.png";

  this(real dratio = 1.01, real scale = 0.5) {
    super(dratio, scale);
    sr.setOpac(250);
  }

  override void loop() {
    sr.setOpac(sr.opac - 2);
    super.loop();
  }
}