module game.entities.Enemy;

import engine;
import game;

class Enemy: GameObject {
  Status status;
  Transform tform;
  RigidBody rigid;
  int type;
  immutable string imgdir = "default.png";
  protected const Vec2 initPos;

  this(const Vec2 initPos = Vec2(0, 0)) {
    status = register(new Status(10));
    this.initPos = initPos;
    addTag("Enemy");
  }

  override void setup() {
    tform = register(new Transform);
    tform.pos = initPos;

    auto enemy = new ImageAsset(imgdir);
    auto rend = register(new SpriteRenderer(enemy));

    auto colid = register(new BoxCollider(rend.size));

    eachsetup;
  }

  override void loop(){
    if(status.life <= 0) destroy;
    
    eachloop;
  }

  void eachsetup() {}; // 各自の初動処理

  void eachloop() {}; // 各自のループ処理
}
