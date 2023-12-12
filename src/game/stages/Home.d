module game.stages.Home;

import engine;
import game;

class Home: Stage {
  Hero hero;
  ImageAsset bg;

  this() {
    hero = register(new Hero);
    bg = new ImageAsset("assets/background.png");
    


    //auto missile = register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
  }
}
