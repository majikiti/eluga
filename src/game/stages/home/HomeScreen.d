module game.stages.home.HomeScene;

import std;
import game;
import engine;

class HomeScene: GameObject {
  Hero hero;
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  // 仮工事
  real theta = 0;

  override void setup() {
    // vv hero vv
    hero = register(new Hero);
    register(new Block(Vec2(0,340),Vec2(1,1)));
    register(new Block(Vec2(400,280),Vec2(1,1)));
    register(new Enemy(Vec2(500,100)));

    // vv worldTrf vv
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;

    // vv background vv
    bg = new ImageAsset("_.jpeg");
    auto sprite = register(new SpriteRenderer(bg));
    debug sprite.debugFrame = false;

    // vv userInterface vv
    register(new UI);

    // vv bgm vv
    BGM = new AudioAsset("maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
  }

  //override void loop() {
  //  // 仮工事2.0
  //  auto wave = 100 * (2 + sin(theta));
  //  theta += 0.04;
  //  tform.pos = Vec2(wave, 0);
  //}
}
