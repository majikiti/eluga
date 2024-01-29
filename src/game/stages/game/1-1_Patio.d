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
    layer = -100;
    this.router = router;
    // vv worldTrf vv
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;
  }

  override void setup() {
    getCamera().lim.min.x = 0;
    getCamera().lim.max.x = 13185;
    getCamera().lim.max.y = 200;
    gm.worldBegin.x = 0;
    gm.worldEnd = Vec2(13185, 500) + windowSize/2;

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
  }
}
