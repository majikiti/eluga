module game.entities.Enemy;

import engine;
import game;

class Enemy: GameObject {
  int life;
  int type;
  immutable string imgdir = "enemy.png";
  private const Vec2 initPos;

  this(const Vec2 initPos = Vec2(0, 0)) {
    this.initPos = initPos;
  }

  override void setup() {
    auto tform = register(new Transform);
    tform.pos = initPos;

    auto enemy = new ImageAsset(imgdir);
    register(new SpriteRenderer(enemy));
  }
}
