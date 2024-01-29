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
    // vv hero vv
    // hero = register(new Hero);
    // register(new Block(Vec2(0,280),Vec2(10,0.3)));
    register(new MakeDonMap(Vec2(64,64)));

    // register(new Enemy3(Vec2(200, 0), hero.component!Transform));

    // vv background vv
    register(new BackGround("_.jpeg"));

    // vv userInterface vv
    register(new UI);

    // vv bgm vv
    BGM = new AudioAsset("maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);

  }

  override void loop() {
    if(im.keyOnce(27)) nuke;
    if(gm.heroStatus){
      if(gm.heroStatus.life <= 0){
        router.go(Routes.GameOver);
      }
    }
  }
}
