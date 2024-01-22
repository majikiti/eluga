module game.stages.game.Patio;

import std;
import engine;
import game;

class Patio: RouteObject {
  Don!"Patio.don" don;

  Hero hero;
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  // 仮工事
  real theta = 0;

  this(Router router) {
    this.router = router;
    layer = -100;
  }

  override void setup() {
    // vv hero vv
    hero = register(new Hero);
    register(new Block(Vec2(0,280),Vec2(100,0.3)));
    for(int i = 0; i < 1000; i++){
      register(new Enemy3(Vec2(i * 400 + 100,100),hero.component!Transform));
      register(new Enemy2(Vec2(i * 400 + 200, 30)));
    }

    // vv worldTrf vv
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;

    // vv background vv
    bg = new ImageAsset("_.jpeg");
    auto sprite = register(new SpriteRenderer(bg, true));
    debug sprite.debugFrame = false;

    // vv userInterface vv
    register(new UI);

    // vv bgm vv
    BGM = new AudioAsset("maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
  }

  override void loop() {
    if(gm.playerStatus){
      if(gm.playerStatus.life <= 0){
        router.go(Routes.GameOver);
      }
    }
  }

  debug:

  bool debugFrame = true;
  override void debugLoop() {
    if(!debugFrame) return;
    if(im.keyOnce('k')) gm.playerStatus.life = 1;
    if(im.keyOnce('=')) router.go(Routes.GameOver);
  }
}
