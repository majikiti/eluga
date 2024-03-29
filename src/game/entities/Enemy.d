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
  int point() => 0;
  AudioAsset itai;
  AudioSource se;

  int heal = 0;

  this(const Vec2 initPos = Vec2(0, 0)) {
    status = gm.makeStatus(this, 10);
    gm.enemyNum++;
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
    if(status.life <= 0 || tform.pos.y >= gm.worldEnd.y){
      death;
      return;
    }
    
    if(tform.pos.x < gm.worldBegin.x) tform.pos.x = gm.worldBegin.x;
    if(tform.pos.x + rend.size.x > gm.worldEnd.x) tform.pos.x = gm.worldEnd.x - rend.size.x;
    if(tform.pos.y < gm.worldBegin.y) tform.pos.y = gm.worldBegin.y;
    auto rend = component!SpriteRenderer;
    active = tform.hidein(rend.size, 40);
  }

  override void collide(GameObject go){
    if(status.willDead) return; // 死ぬ時ぐらいはそっとしてあげよう
    auto rb = component!RigidBody;
    auto tform = component!Transform;
    if(go.getTag("Hero") && !gm.heroStatus.star){
      Status* pstat = gm.heroStatus;
      pstat.star = true;
      pstat.life -= 1;
    }
    if(go.getTag("Missile")) {
      register(new Damage);
    }
  }

  void death() {
    gm.point += point;
    if(!status.willDead) {
      component!SpriteRenderer.active = false;
      register(new Explosion);
      se.volume(50);
      se.play(0);
    }
    auto rb = component!RigidBody;
    rb.a = rb.v = Vec2(0, 0);
    status.willDead = true;
    if(has!Explosion) return;
    gm.enemyNum--;
    gm.heroStatus.life += heal;
    if(gm.heroStatus.life > gm.heroStatus.maxlife) gm.heroStatus.life = gm.heroStatus.maxlife;
    destroy;
  } // 死と向き合う関数
}
