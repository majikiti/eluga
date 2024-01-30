module game.stages.title.TitleScene;

import engine;
import game;

class TitleScene: RouteObject {
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;
  NTimer tmr; // gomi -> kami
  Curtain cu;

  this() {
    tmr = register(new NTimer);
    tmr.sched(&toAbs, 15_000);
    cu = register(new Curtain([0, 0, 0], 5));
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
    auto title = register(new TextBox("ホンジュラス革命", Vec2(100,100)));
    auto text = register(new TextBox("Pless Enter", Vec2(200,200), true));
    title.component!Transform.scale *= 1.5;
    tmr.reset;
  }

  override void loop() {
    if(im.keyOnce('\r')) toGame;
  }

  void toAbs() {
    cu.close(&rtabs);
  }

  void toGame() {
    cu.close(&rtgme);
  }

  void rtabs() => router.go(Routes.Abstract);
  void rtgme() => router.go(Routes.Game);

  override void route() {
    cu.open;
    tmr.reset;
  }
}
