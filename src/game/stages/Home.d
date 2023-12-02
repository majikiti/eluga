module game.stages.Home;

import game;

class Home: Stage {
  Hero hero;

  this() {
    hero = register(new Hero);
  }
}
