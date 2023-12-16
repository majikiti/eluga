module game.stages.titleScene.TitleScene;

import engine;
import game;

class TitleScene: Stage {
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  this() {
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;
    bg = new ImageAsset("assets/_.jpeg");
    register(new SpriteRenderer(bg));
  }

  override void setup(){
    BGM = new AudioAsset("assets/maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
    auto title = register(new TitleText);
  }
}
