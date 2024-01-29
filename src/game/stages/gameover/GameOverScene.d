module game.stages.gameover.GameOverScene;

import std;
import game;
import engine;

class GameOverScene: RouteObject {
  TextBox tl, tls, tl2;
  ImageBox image;
  AudioAsset BGM;
  AudioSource audio;
  Focus fc;
  Fade fd;
  Curtain cu;
  real theta;

  this() {
    tl = register(new TextBox("死を賜った", windowSize/2-Vec2(100, 50)));
    tl.component!Text.setColor(255, 0, 0);

    tls = register(new TextBox(text("最終スコア: ", gm.ds.point), windowSize/2 - Vec2(80, 0)));
    tls.tform.scale *= 0.5;
    tls.component!Text.setColor(180, 180, 0);

    tl2 = register(new TextBox("Press Enter", windowSize/2+Vec2(-80, 70), true));
    tl2.component!Text.setColor(255, 255, 255);
    tl2.tform.scale *= 0.75;
    fd = register(new Fade([127, 0, 0], 50));
    cu = register(new Curtain);
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

  override void route() {
    cu.open;
  }
}
