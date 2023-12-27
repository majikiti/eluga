module game.stages.title.TitleScene;

import engine;
import game;

class TitleScene: GameObject {
  ImageAsset bg;
  AudioAsset BGM;
  AudioSource audio;
  Transform tform;

  override void setup(){
    tform = register(new Transform(Transform.Org.World));
    tform.scale.x = 1.5;
    bg = new ImageAsset("_.jpeg");
    register(new SpriteRenderer(bg));
    BGM = new AudioAsset("maou_bgm_8bit29.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(15);
    auto title = register(new TextBox("Hello"));
  }
}
