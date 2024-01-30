module game.entities.Bomb;

import std;
import game;
import engine;

class Bomb : GameObject {
  enum Affi {
    Enemy,
    Hero,
  }

  SpriteRenderer rend;
  Transform tform;
  RigidBody rigid;
  string imgdir() => "bomb.png";
  AudioSource se;
  Affi af;

  bool isExplosion = false;

  this(Affi af = Affi.Enemy) {
    auto bokan = new AudioAsset("dogaan.mp3");
    se = register(new AudioSource(bokan));
    se.volume(60);
    addTag("Bomb");
    // 僕はHikakin 死亡
    tform = register(new Transform(tform.Org.Spawn));
    tform.scale = Vec2(0.2, 0.2);
    this.af = af;
  }

  override void setup() {
    auto bomb = new ImageAsset(imgdir);
    rend = register(new SpriteRenderer(bomb));

    rigid = register(new RigidBody(1));
    auto colid = register(new BoxCollider(rend.size + Vec2(0, 300)));
  }

  override void loop() {
    if(isExplosion) rend.active = false;
    if(isExplosion && !has!Explosion) destroy;
  }

  override void collide(GameObject go) {
    if(go.getTag("Missile") || af == Affi.Hero) explosion(go);
    else if(go.getTag("Hero")) {
      auto aa = new AudioAsset("gather.mp3");
      se.set(aa);
      se.volume(100);
      se.play(0);
      gm.heroStatus.haveObj ~= new Bomb(Affi.Hero);
      bye;
    }
  }

  void explosion(GameObject go) {
    if(!isExplosion) {
      component!BoxCollider.isTrigger = true;

      // damage function
      real dmgf(real x) => (12 * max(0, exp(-1 * x / 300) - 0.1));
      // damage calc
      auto ptf = gm.hero.component!Transform;
      Vec2 r = ptf.pos - tform.pos;
      real len = r.size;
      Status* stat;
      if(af == Affi.Enemy) {
        stat = gm.heroStatus();
      } else {
        if(go.getTag("Hero")) return;
        auto keys = go in gm.status;
        if(keys !is null) stat = gm.status[go];
        else return;
      }
      if(!stat.star) stat.life -= cast(int)dmgf(len);
      rigid.addForce(r * dmgf(len));
      // dbg("damaged! :", dmgf(len));

      se.play(1);
      register(new Explosion);
      isExplosion = true;
    }
  } // 爆発は芸術なのかもしれませんね
}
