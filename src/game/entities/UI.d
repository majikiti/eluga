module game.entities.UI;

import std;
import engine;
import game;

class UI: GameObject {
  override void setup() {
    // timers
    register(new TimeLimitClock);

    // points
    register(new Point);

    // and more...
  }
}
