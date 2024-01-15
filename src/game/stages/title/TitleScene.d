module game.stages.title.TitleScene;

import engine;
import game;

class TitleScene: RouteObject {
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;
  Timer hoge; // gomi
  Fade fd;

  this() {
    hoge = new Timer;
  }

  override void setup(){
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;
    bg = new ImageAsset("_.jpeg");
    register(new SpriteRenderer(bg));
    BGM = new AudioAsset("8_bit_Poplar.mp3");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
    auto title = register(new TextBox("Hello"));
    fd = register(new Fade([255, 0, 0]));
  }

  override void loop() {
    if(hoge.cur > 1/*5_000*/) router.go(Routes.Home);
  }
}
