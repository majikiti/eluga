module game.entities.Missile;

import engine;

class Missile: GameObject {
  enum Type {
    Normal,
  }

  Type type;

  this(Type type, Vec2 dir, Vec2 pos) {
    this.type = type;

    auto tform = register(new Transform);
    tform.pos = pos;
    tform.scale = Vec2(0.5,0.5);
    auto rb = register(new RigidBody(1));
    rb.a = Vec2(0, 0);
    auto missile = new ImageAsset("hero0.png");
    auto rend = register(new SpriteRenderer(missile));

    auto col = register(new BoxCollider(rend.size));
    col.isTrigger = true;

    final switch(type) {
      case Type.Normal:
        if(dir.x >= 0) rb.addForce(Vec2(500, 0));
        else rb.addForce(Vec2(-500, 0));
        rb.g = Vec2(0, 0);
        break;
    }

    auto clip = new AudioAsset("se_rifle01.mp3");
    // auto audio = register(new AudioSource(clip));
    // audio.volume(20);
    // audio.play();
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    tform.rot++;
    if(tform.pos.x > 3000 || tform.pos.y > 1000) destroy;
    final switch(type) {
      case Type.Normal: break;
    }
  }
  
  override void collide(GameObject go){
    if(go.getTag("Enemy"))go.component!Status.life -= 1;
    if(go.getTag("Ground") || go.getTag("Enemy")) destroy;
  }
}
