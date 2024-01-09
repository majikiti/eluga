module game.stages.gameover.GameOverScene;

import std;
import game;
import engine;

class GameOverScene: GameObject {
  Title tl;
  AudioAsset BGM;
  AudioSource audio;
  Focus fc;
  real theta;

  override void setup() {
    tl = register(new Title("死を賜った"));
    tl.component!Text.setColor(255, 0, 0);
    tl.tform.pos = Vec2(200, 200);

    BGM = new AudioAsset("DPRKfuneral.ogg");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(50);
  }

  //override void loop() {
  //  tl.tform.pos = Vec2(200, 200 + 10 * cos(theta));
  //  theta += 0.0001;
  //}
}