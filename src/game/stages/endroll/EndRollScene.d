module game.stages.endroll.EndRollScene;

import std;
import engine;
import game;

class EndRollScene : RouteObject {
  mixin(enableReincarnate);
  
  TextBox[] tl;
  Transform tf;
  AudioAsset BGM;
  AudioSource audio;
  Focus fc;
  Timer tmr;
  bool stop;

  this() {
    tf = register(new Transform);
    tf.pos.y = windowSize.y - 200;

    string[] cont = [
      "こうして革命は成された。",
      "再び南北アメリカは統一され、魔法少女は\n皇帝に即位し、宇宙を征服した。",
      "\n",
      "ホンジュラス革命",
      "2023年度-D4ソフトウェア工学",
      "Produced by チームeluga",
      "",
      "ホンジュラスに栄光あれ!",
    ];

    foreach(i, c; cont){
      tl ~= register(new TextBox(c));
      tl[i].component!Text.setColor(225, 225, 255);
      tl[i].tform.pos = Vec2(20, 200 + i * 100);
    }

    tmr = new Timer;
  }

  override void setup() {
    BGM = new AudioAsset("The_distant_TERRA.mp3");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(30);
  }

  override void loop() {
    if(tmr.cur>=50 && !stop) {
      tf.pos -= Vec2(0, 2);
      if(im.key('d')) tf.pos -= Vec2(0, 2) * 9;
      tmr.reset;
    }
    if(im.keyOnce('\r')) router.go(Routes.Title);
    if(stop && tmr.cur > 5_000) router.go(Routes.Title);
    if(tf.worldPos.y <= -400 && !stop) {stop = true; tmr.reset;}
  }
}