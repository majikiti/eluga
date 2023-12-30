module game.Game;

import engine;
import game;

class Game: GameObject {
  // Router router;

  this() {
    //stage = register(new Home);
    // router = new Router!(
    //   "home",   ctx => new Home(ctx),
    //   "title",  ctx => new Title(ctx),
    // );
  }

  override void setup() {
    register(new HomeScene);

    // test msg
    // dbg("Hello, This is DBG");
    // log("Hello, This is LOG");
    // warn("Hello, This is WARN");
    // err("Hello, This is ERR");
    // dbg("Super Long Message: We workers have been exploited daily by the bourgeoisie, which is why we are now being hunted by a sense of mission that we must make a revolution");
    // log("Super Long Message: We workers have been exploited daily by the bourgeoisie, which is why we are now being hunted by a sense of mission that we must make a revolution");
    // warn("Super Long Message: We workers have been exploited daily by the bourgeoisie, which is why we are now being hunted by a sense of mission that we must make a revolution");
    // err("Super Long Message: We workers have been exploited daily by the bourgeoisie, which is why we are now being hunted by a sense of mission that we must make a revolution");
  }
}
