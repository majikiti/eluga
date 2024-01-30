module game.stages.gameclear.GameClearScene;

import std;
import game;
import engine;

class GameClearScene: RouteObject {
  mixin(enableReincarnate);
  
  TextBox tl, tl2, tls;
  ImageBox image;
  AudioAsset BGM;
  AudioSource audio;
  Focus fc;
  Fade fd;
  NTimer tmr;
  Curtain cu;

  this() {
    tl = register(new TextBox("君はホンジュラスを救った", windowSize/2-Vec2(100, 50)));
    tl.component!Text.setColor(255, 200, 0);

    tls = register(new TextBox(text("最終スコア: ", gm.ds.point), windowSize/2 - Vec2(80, -30)));
    tls.tform.scale *= 0.7;
    tls.component!Text.setColor(180, 180, 0);

    tl2 = register(new TextBox("Press Enter", windowSize/2+Vec2(-80, 130), true));
    tl2.component!Text.setColor(255, 255, 255);
    tl2.tform.scale *= 0.75;
    fd = register(new Fade([0x00, 0xbd, 0xe5], 50));

    auto py = register(new Donji(Vec2(50, windowSize.y / 8)));

    tmr = register(new NTimer);
    tmr.sched(&toEroll, 10_000);
    cu = register(new Curtain);
  }
 
  override void setup() {
    register(new OmedetoPoint);
    register(new OmedetoPoint(-0.023));
    BGM = new AudioAsset("DPRKglad.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(50);
  }

  override void loop() {
    if(im.keyOnce('\r')) toEroll;
    if(!fd.isChanging) fd.swap;
  }

  void toEroll() {
    void cgan() => router.go(Routes.Eroll);
    cu.close(&cgan);
  }
}

class OmedetoPoint: GameObject {
  // cos 1: sin 8

  Transform tf;
  NTimer tmr;
  WindowParam wp;

  real dtheta = 0, phase = 0, theta = 0;

  this(real dtheta = 0.007) {
    wp = new WindowParam;
    tmr = register(new NTimer);
    tf = register(new Transform);
    tf.pos = windowSize / 2;
    auto randomSrc = Random(cast(uint)tmr.cur);
    phase = uniform(0, 2 * PI, randomSrc);
    this.dtheta = dtheta;
  }

  override void setup() {
    tmr.sched(&sarmon_summon, 1_001);
  }

  override void loop() {
    tf.pos = (windowSize / 2) + Vec2(cos(theta + phase), sin(8 * theta + phase)) * (windowSize / 4);
    theta += dtheta;
    // dbg(tf.pos);
  }

  void sarmon_summon() {
    register(new Explosion(1.3, [0x95, 0xff, 0x00], [0xff, 0x69, 0xb6], [0x00, 0x08, 0xff]));
  }
}

class Donji : GameObject {
  Transform tf;
  SpriteRenderer sr;

  Vec2 initVec;
  real addnum = -0.05, theta = 0;

  this(Vec2 initVec) {
    tf = register(new Transform);
    tf.scale = Vec2(5, 5);
    auto ia = new ImageAsset("hero0.png");
    sr = register(new SpriteRenderer(ia));
    this.initVec = initVec;
    tf.pos = initVec;
  }

  override void loop() {
    tf.scale.x += addnum;
    tf.pos.x = initVec.x + (windowSize.x / 8) * (1 + sin(theta));
    if(abs(tf.scale.x) >= 5) addnum *= -1;
    theta += 0.01;
  }
}
