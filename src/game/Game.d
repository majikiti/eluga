module game.Game;

import engine;
import game;

class Game: GameObject {
  // Router router;

  this() {
    //stage = register(new Home);
    register(new TitleScene);
    // router = new Router!(
    //   "home",   ctx => new Home(ctx),
    //   "title",  ctx => new Title(ctx),
    // );
  }
}
