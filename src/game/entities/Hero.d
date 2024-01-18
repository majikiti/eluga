module game.entities.Hero;

import std;
import sdl_mixer;
import engine;
import game;

class Hero: GameObject {
  Status status;
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

  Vec2 v = Vec2(2, 2);

  override void setup() {
    tform = register(new Transform(Transform.Org.World));
    tform.pos = Vec2(0, 100);
    register(new RigidBody(1)).a = Vec2(0, 0);

    auto hero0 = new ImageAsset("hero0.png");
    rend = register(new SpriteRenderer(hero0));
    register(new BoxCollider(rend.size));
    register(new Focus(3)); 
    register(new Kalashnikov);
    status = register(new Status);
    register(new LifeIndicator(status));
    addTag("Player");

    gm.player = this;

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
      } 
      if(im.key('a')){
        rb.v.x = -v.x;
        dir.x = -1;
      }
      if(dashtmr.cur >= 1000) isDash = true;
      if(dashtmr.cur >= 250 && isDash){
        auto dust = register(new Dust);
        dust.component!Transform.pos += Vec2(0, 100);
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
      register(new Missile(Missile.Type.Normal, dir, tform.pos + Vec2(0,20)));
    }

    if(gm.playerStatus.star && sterTime > timer){
      rend.active = !rend.active;
      timer += dur;
    }
    else timer = 0, gm.playerStatus.star = false, rend.active = true;

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
}
