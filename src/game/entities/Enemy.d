module game.entities.Enemy;

import engine;
import game;

class Enemy: GameObject {
  Status* status;
  Transform tform;
  RigidBody rigid;
  SpriteRenderer rend;
  int type;
  protected const Vec2 initPos;
  string imgdir() => "default.png";
  AudioAsset itai;
  AudioSource se;

  this(const Vec2 initPos = Vec2(0, 0)) {
    status = gm.makeStatus(this,10);
    itai = new AudioAsset("explosion.ogg");
    se = register(new AudioSource(itai));
    se.volume(50);
    this.initPos = initPos;
    addTag("Enemy");
  }

  override void setup() {
    tform = register(new Transform);
    tform.pos = initPos;

    auto enemy = new ImageAsset(imgdir);
    rend = register(new SpriteRenderer(enemy));

    auto colid = register(new BoxCollider(rend.size));
  }

  override void loop(){
    if(status.life <= 0){
      death;
    }
    auto rend = component!SpriteRenderer;
    active = tform.isin(rend.size);
  }

  override void collide(GameObject go){
    if(status.willDead) return; // 死ぬ時ぐらいはそっとしてあげよう
    auto rb = component!RigidBody;
    auto tform = component!Transform;
    if(go.getTag("Player") && !gm.playerStatus.star){
      Status* pstat = gm.playerStatus;
      pstat.star = true;
      pstat.life -= 1;
    }
    if(go.getTag("Missile")) {
      register(new Damage);
    }
  }

  void death() {
    if(!status.willDead) {
      se.play(1);
      register(new Explosion);
    }
    status.willDead = true;
    if(has!Explosion) return;
    destroy;
  } // 死と向き合う関数
}
