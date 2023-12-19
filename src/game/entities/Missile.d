module game.entities.Missile;

import engine;

class Missile: GameObject {
  enum Type {
    Normal,
  }

  int id;
  Type type;
  Vec2 d;

  this(Type t, Vec2 direction, Vec2 pos) {
    register(new Transform(Transform.Org.World)).pos = pos;
    register(new RigidBody(1)).a = Vec2(0, 0);
    auto missile = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(missile));
    this.type = t;
    this.d = direction;
    /*
    auto missile = new ImageAsset("");
    register(new SpriteRenderer(missile));
    */
  }

  override void setup() {
    auto rb = component!RigidBody;
    Vec2 f;
    final switch(type) {
      case Type.Normal:
        if(this.d.x >= 0) f = Vec2(3, 0);
        else f = Vec2(-3, 0);
        break;
    }
    rb.addForce(f);

    auto clip = new AudioAsset("assets/se_rifle01.mp3");
    // auto audio = register(new AudioSource(clip));
    // audio.volume(20);
    // audio.play();
  }

  override void loop() {
    auto tform = component!Transform;
    tform.rot++;
    if(tform.pos.x > 1000 || tform.pos.y > 1000) destroy;
    final switch(this.type){
      case Type.Normal: break;
    }
  }
}
