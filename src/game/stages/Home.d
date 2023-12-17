module game.stages.Home;

import engine;
import game;

class Home: Stage {
  Hero hero;
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  override void setup(){
    hero = register(new Hero);
    
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;

    bg = new ImageAsset("assets/_.jpeg");
    register(new SpriteRenderer(bg));
    register(new UI);

    BGM = new AudioAsset("assets/maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
  }
}
