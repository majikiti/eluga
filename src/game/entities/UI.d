module game.entities.UI;

import std;
import engine;
import game;

class UI: GameObject {
  Transform tf;

  this() {
    tf = register(new Transform(tf.Org.World));
  }

  override void setup() {
    // timers
    register(new TimeLimitClock);

    // points
    register(new Point);

    // and more...
  }

  override void loop() {
    tf.pos = getCamera().pos;
  }
}
