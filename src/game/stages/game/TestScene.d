module game.stages.game.TestScene;

import std;
import engine;
import game;

class TestScene: RouteObject {
  Don!"Patio.don" don;

  Hero hero;
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  this() {
    layer = -100;
    // vv worldTrf vv
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;
  }

  override void setup() {
    // vv hero vv
    // hero = register(new Hero);
    // register(new Block(Vec2(0,280),Vec2(10,0.3)));
    register(new MakeDonMap(Vec2(64,64)));

    // register(new Enemy3(Vec2(200, 0), hero.component!Transform));

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
    if(im.keyOnce(27)) nuke;
  }
}
