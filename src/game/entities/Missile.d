module game.entities.Missile;

import engine;
import game;
import std;

class Missile: GameObject {
  enum Type {
    Normal,
    CCCP,
    Divergence,
  }
  enum Target {
    Hero,
    Enemy,
  }

  Type type;
  Target target;
  string tStr;

  this(Type type, Vec2 dir, Vec2 pos, Target target) {
    this.type = type;
    this.target = target;
    final switch(target){
      case Target.Hero:
        tStr = "Hero";
        addTag("EnemyMissile");
        break;
      case Target.Enemy:
        tStr = "Enemy";
        addTag("Missile");
        break;
    }

    auto tform = register(new Transform(Transform.Org.World));
    tform.pos = pos;
    tform.scale = Vec2(0.1,0.1);
    auto rb = register(new RigidBody(1));
    rb.a = Vec2(0, 0);
    auto missile = new ImageAsset("bullet.png");
    auto rend = register(new SpriteRenderer(missile));

    auto col = register(new BoxCollider(rend.localSize));
    col.isTrigger = true;

    final switch(type) {
      case Type.Normal:
        if(dir.x >= 0) rb.v = Vec2(10, 0);
        else rb.v = Vec2(-10, 0);
        rb.g = Vec2(0, 0);
        break;
      case Type.CCCP:
        rb.m = 1;
        rb.g = Vec2(0, 1);
        rb.v = dir / 8;
        break;
      case Type.Divergence:
        rb.addForce(dir * 3);
        rb.g = Vec2(0, 0);
    }

    //auto clip = new AudioAsset("se_rifle01.mp3");
    // auto audio = register(new AudioSource(clip));
    // audio.volume(20);
    // audio.play();
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    auto rend = component!SpriteRenderer;
    // tform.rot++;
    if(!tform.isin(rend.size)) destroy;
    //if(tform.pos.x > 1000 || tform.pos.y > 1000 || tform.pos.x < -1000 || tform.pos.y < -1000) destroy;
    final switch(type) {
      case Type.Normal: break;
      case Type.Divergence: break;
      case Type.CCCP: break;
    }
  }

  override void collide(GameObject go){
    if(go.getTag(tStr) && !gm.getStatus(go).star) {
      gm.getStatus(go).life -= 1;
      if(target == Target.Hero) gm.heroStatus.star = true;
    }
    if(go.getTag("Ground") || go.getTag(tStr) || go.getTag("Bomb")) destroy;
  }
}
