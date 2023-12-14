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
    
    BGM = new AudioAsset("assets/maou_se_system49.wav");
    audio = register(new AudioSource(BGM));
    log(audio.play(true));
    //auto missile = register(new Missile(Missile.Type.Normal, Vec2(1, 0)));
  }
}
