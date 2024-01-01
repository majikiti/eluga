module game.entities.Enemy;

import engine;
import game;

class Enemy: GameObject {
  Status status;
  int type;
  immutable string imgdir = "enem1.png";
  private const Vec2 initPos;

  this(const Vec2 initPos = Vec2(0, 0)) {
    status = register(new Status(10));
    this.initPos = initPos;
    addTag("Enemy");
  }

  override void setup() {
    auto tform = register(new Transform);
    tform.pos = initPos;

    auto enemy = new ImageAsset(imgdir);
    auto rend = register(new SpriteRenderer(enemy));

    auto colid = register(new BoxCollider(rend.size));
    auto rigid = register(new RigidBody(1));
  }

  override void loop(){
    if(status.life <= 0) destroy;
  }
}
