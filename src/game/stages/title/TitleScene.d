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
    auto wp = new WindowParam;
    tform.scale = wp.size / Vec2(3840, 2160);
    bg = new ImageAsset("titlebg.png");
    register(new SpriteRenderer(bg));
    BGM = new AudioAsset("8_bit_Poplar.mp3");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
    auto title = register(new TextBox("ホンジュラス革命", Vec2(150,100)));
    auto text = register(new TextBox("Pless Enter", Vec2(200,200), true));
    fd = register(new Fade([255, 0, 0]));
  }

  override void loop() {
    if(im.keyOnce('\r')) router.go(Routes.Game);
  }
}
