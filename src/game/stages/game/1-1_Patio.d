module game.stages.game.Patio;

import std;
import engine;
import game;

class Patio: RouteObject {
  Don!"Patio.don" don;

  Hero hero;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  this(Router router) {
    register(new CoolText("全員抹殺せよ"));
    layer = -100;
    this.router = router;
    // vv worldTrf vv
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;
  }

  override void setup() {
    getCamera().lim.min.x = 0;
    getCamera().lim.min.y = -300;
    getCamera().lim.max.x = 12500;
    getCamera().lim.max.y = 200;
    gm.worldBegin = Vec2(0, -300);
    gm.worldEnd = Vec2(12500, 200) + windowSize;

    register(new MakeDonMap(Vec2(64,64)));

    // vv background vv
    auto beijing = register(new BackGround("bg.png"));
    beijing.component!Transform.pos = Vec2(0, -450); // align BG

    // vv userInterface vv
    register(new UI);

    // vv bgm vv
    BGM = new AudioAsset("war.mp3");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);

  }

  override void loop() {
    if(im.keyOnce(27)) nuke;
    if(gm.heroStatus){
      if(gm.heroStatus.dead){
        router.go(Routes.GameOver);
      }
    }
    if(gm.enemyNum <= 0) router.go(Routes.GameClear);
  }
}
