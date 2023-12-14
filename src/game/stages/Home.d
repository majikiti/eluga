module game.stages.Home;

import engine;
import game;

class Home: Stage {
  Hero hero;
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;

  this() {
    hero = register(new Hero);
    bg = new ImageAsset("assets/background.png");
    //auto missile = register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
  }

  override void setup(){
    BGM = new AudioAsset("assets/maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.volume(1);
    log(audio.play(true));
  }
}
