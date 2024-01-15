module game.effects.Dust;

import std;
import game;
import engine;

class Dust : Effect {
  override string imdir() => "effect/smoke.png";

  this(real dratio = 0.99, real scale = 0.2) {
    super(dratio, scale);
  }

  override void loop() {
    super.loop();
  }
}