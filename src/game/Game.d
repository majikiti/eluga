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

  override void setup(){
    
    dbg("CWGB: ", register(new HomeScene));
  }
}
