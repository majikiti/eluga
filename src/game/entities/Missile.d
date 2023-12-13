module game.entities.Missile;

import engine;

class Missile: GameObject {
  enum Type {
    Normal,
  }

  int id;
  Type type;
  Vec2 d;

  this(Type t, Vec2 direction) {
    register(new Transform);
    register(new RigidBody);
    auto missile = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(missile));
    this.type = t;
    final switch(t) {
      case Type.Normal:
        if(direction.x >= 0) d = Vec2(3, 0);
        else d = Vec2(-3, 0);
        break;
    }

    /*
    auto missile = new ImageAsset("");
    register(new SpriteRenderer(missile));
    */
  }

  override void setup() {
    auto rb = component!RigidBody;
    rb.v = d;
    final switch(this.type){
      case Type.Normal: break;
    }
  }

  override void loop() {
    auto tform = component!Transform;
    if(tform.pos.x > 1000)destroy;
    final switch(this.type){
      case Type.Normal: break;
    }
  }
}
