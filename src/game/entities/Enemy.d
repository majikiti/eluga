module game.entities.Enemy;

import engine;
import game;

class Enemy: GameObject {
  int life;
  int type;
  immutable string imgdir = "assets/enemy.png";

  override void setup(){
    register(new Transform);

    auto enemy = new ImageAsset(imgdir);
    register(new SpriteRenderer(enemy));
  }
}
