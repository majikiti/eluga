module game.stages.gameover.GameOverScene;

import std;
import game;
import engine;

class GameOverScene: RouteObject {
  TextBox tl, tl2;
  ImageBox image;
  AudioAsset BGM;
  AudioSource audio;
  Focus fc;
  Fade fd;
  real theta;

  this() {
    tl = register(new TextBox("死を賜った"));
    tl.component!Text.setColor(255, 0, 0);
    tl.tform.pos = Vec2(200, 200);

    tl2 = register(new TextBox("Press Enter"));
    tl2.component!Text.setColor(255, 255, 255);
    tl2.tform.pos = Vec2(220, 350);
    tl2.tform.scale *= 0.75;
    fd = register(new Fade([127, 0, 0], 50));
  }
 
  override void setup() {
    BGM = new AudioAsset("DPRKfuneral.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(50);
  }

  override void loop() {
    if(im.keyOnce('\r')) router.go(Routes.Title);
    if(!fd.isChanging) fd.swap;
  }
}
