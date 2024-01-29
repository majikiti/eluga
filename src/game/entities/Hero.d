module game.entities.Hero;

import std;
import sdl_mixer;
import engine;
import game;

class Hero: GameObject {
  Status* status;
  SpriteRenderer rend;
  int type;
  real time = 0,jumpSpeed = 3, sterTime = 100, timer = 0;
  Transform tform;
  // ^そのうちStatusに改修する(誰かやってくれるとぼくはうれしいです)
  Vec2 dir = Vec2(1,0);

  // ジャンプ関連
  enum DefaultJumpRemain = 1;
  int jumpRemain = DefaultJumpRemain;
  bool fromGround = false;

  Timer rndtmr;
  Timer dashtmr;
  bool isDash;
  Kalashnikov ak;

  AudioAsset SHOT;
  AudioSource audio;

  Vec2 v = Vec2(3, 2);

  override void setup() {
    tform = register(new Transform(Transform.Org.World));
    tform.pos = Vec2(0, 100);
    register(new RigidBody(1)).a = Vec2(0, 0);

    auto hero0 = new ImageAsset("hero0.png");
    rend = register(new SpriteRenderer(hero0));

    SHOT = new AudioAsset("attack_heavy.mp3");
    audio = register(new AudioSource(SHOT));

    register(new BoxCollider(rend.size));
    register(new Focus(3));
    ak = register(new Kalashnikov);
    status = gm.makeStatus(this);
    register(new LifeIndicator(status));
    addTag("Hero");

    gm.hero = this;

    rndtmr = new Timer;
    dashtmr = new Timer;
  }

  override void loop() {
    scope(exit) fromGround = false;
    
    //auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(im.key('d')||im.key('a')){
      if(im.key('d')){
        rb.v.x = v.x;
        dir.x = 1;
        if(tform.scale.x < 0) tform.scale.x *= -1;
      } 
      if(im.key('a')){
        rb.v.x = -v.x;
        dir.x = -1;
        if(tform.scale.x > 0) tform.scale.x *= -1;
      }
      if(dashtmr.cur >= 1000) isDash = true;
      if(dashtmr.cur >= 250 && isDash){
        auto dust = register(new Dust);
        dust.component!Transform.initPos = Vec2(0, rend.size.x);
        dashtmr.reset;
      }
    }else{
      rb.v.x = 0;
      rb.v.x = 0;
      isDash = false;
      dashtmr.reset;
    }

    if(!fromGround) dashtmr.reset;

    //jump
    if(jumpRemain > 0 && im.keyOnce(' ')){
      rb.v = Vec2(0, -jumpSpeed);
      // 1回増やす
      if(!fromGround) jumpRemain--;
      fromGround = false;
    }

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, dir, tform.pos + Vec2(0,20), Missile.Target.Enemy));
      audio.volume(10);
      audio.play(1);
    }

    if(gm.heroStatus.star && sterTime > timer){
      rend.active = !rend.active;
      timer += dur;
    }
    else timer = 0, gm.heroStatus.star = false, rend.active = true;

    // Effect Test
    auto randomSrc = Random(cast(int)rndtmr.cur);
    if(rndtmr.cur>=uniform(50, 250, randomSrc)) {
      auto wair = register(new WeirdAir);
      wair.component!Transform.pos += Vec2(uniform(0, 50, randomSrc), uniform(0, 120, randomSrc));
      rndtmr.reset;
    }
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    if(go.getTag("Ground") && rb.v.y > -1) {
      jumpRemain = DefaultJumpRemain;
      fromGround = true;
    }
  }

  override void debugLoop(){
    if(!debugging || !dm.speedupX) v.x = 3;

    if(!debugging) return;

    if(dm.speedupX) v.x = 10;
    auto tform = component!Transform;
    if(dm.moonJump){
      if(im.key('w')||im.key('s')){
        if(im.key('s')){
          tform.pos.y += 10;
        } 
        if(im.key('w')){
          tform.pos.y += -10;
        }
      }
    }

    if(dm.noGravity) component!RigidBody.g = Vec2(0, 0);
    else component!RigidBody.g = Vec2(0, 9.81);
  }
}
