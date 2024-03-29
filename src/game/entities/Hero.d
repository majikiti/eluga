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

  // いまなにしてる？
  enum State { Standing, Walking, Jumping, Die }
  auto state = State.Jumping;
  NTimer tmr;

  // skin
  ImageAsset[] walkSkin;
  size_t walkSkinCur;
  auto jumpSkin() => walkSkin[0]; //
  auto standSkin() => walkSkin[1]; //

  Timer rndtmr;
  Timer dashtmr;
  Timer bombdtmr;
  bool isDash;
  Kalashnikov ak;

  AudioAsset SHOT;
  AudioSource audio;
  AudioAsset itai;
  AudioSource se;

  Vec2 v = Vec2(3, 2);

  bool forStar = true;

  void changeSkin(ImageAsset img) {
    component!SpriteRenderer.bye;
    rend = upsert(new SpriteRenderer(img));
    rend.active = forStar;
    upsert(new BoxCollider(rend.size));
  }

  override void setup() {
    gm.point = 0;
    
    tform = register(new Transform(Transform.Org.World));
    tform.pos = Vec2(0, 100);
    register(new RigidBody(1)).a = Vec2(0, 0);

    walkSkin = [
      new ImageAsset("hero0.png"),
      new ImageAsset("hero1.png"),
    ];
    rend = register(new SpriteRenderer(walkSkin[0]));

    SHOT = new AudioAsset("attack_heavy.mp3");
    audio = register(new AudioSource(SHOT));

    register(new BoxCollider(rend.size));
    register(new Focus(3));
    ak = register(new Kalashnikov);
    status = gm.makeStatus(this, 20);
    register(new LifeIndicator(status));
    addTag("Hero");

    itai = new AudioAsset("explosion.ogg");
    se = register(new AudioSource(itai));
    se.volume(50);

    gm.hero = this;

    rndtmr = new Timer;
    dashtmr = new Timer;
    bombdtmr = new Timer;

    tmr = register(new NTimer);
    tmr.sched({
      if(state == State.Walking) {
        auto i = ++walkSkinCur == walkSkin.length ? walkSkinCur = 0 : walkSkinCur;
        changeSkin(walkSkin[i]);
      }
    }, 100);
  }

  override void loop() {
    scope(exit) fromGround = false;
    
    if(status.life <= 0 || tform.pos.y >= gm.worldEnd.y){
      death;
      return;
    }
    
    if(tform.pos.x < gm.worldBegin.x) tform.pos.x = gm.worldBegin.x;
    if(tform.pos.x + rend.size.x > gm.worldEnd.x) tform.pos.x = gm.worldEnd.x - rend.size.x;
    if(tform.pos.y < gm.worldBegin.y) tform.pos.y = gm.worldBegin.y;

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
      if(state == state.Standing) state = state.Walking;
    } else if(im.key('t') && gm.heroStatus.haveObj !is null && gm.heroStatus.haveObj.length != 0 && bombdtmr.cur >= 2_000) {
      auto bm = register(gm.heroStatus.haveObj[$-1]);
      gm.heroStatus.haveObj.popBack;
      bm.component!RigidBody.addForce(Vec2(700, 1000) * dir);
      bm.component!Transform.initPos = Vec2(80, 0) * dir;
      bombdtmr.reset;
    } else {
      rb.v.x = 0;
      rb.v.x = 0;
      isDash = false;
      dashtmr.reset;
      if(state == state.Walking) {
        state = State.Standing;
        changeSkin(standSkin);
      }
    }

    if(!fromGround) dashtmr.reset;

    //jump
    if(jumpRemain > 0 && im.keyOnce(' ')){
      rb.v = Vec2(0, -jumpSpeed);
      // 1回増やす
      if(!fromGround) jumpRemain--;
      fromGround = false;
      state = State.Jumping;
      changeSkin(jumpSkin);
    }

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, dir, tform.pos + Vec2(0,20), Missile.Target.Enemy));
      audio.volume(10);
      audio.play(0);
    }

    if(gm.heroStatus.star && sterTime > timer){
      forStar = !forStar;
      rend.active = forStar;
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
      if(state == State.Jumping) {
        state = State.Standing;
        changeSkin(standSkin);
      }
    }
  }

  void death() {
    state = State.Die;
    if(!status.willDead) {
      gm.ds.point = gm.point;
      component!SpriteRenderer.active = false;
      register(new Explosion);
      se.volume(50);
      se.play(0);
    }
    auto rb = component!RigidBody;
    rb.a = rb.v = Vec2(0, 0);
    status.willDead = true;
    if(has!Explosion) return;
    status.dead = true;
  } // 死と向き合う関数

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
