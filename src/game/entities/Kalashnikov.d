module game.entities.Kalashnikov;

import std;
import sdl_mixer;
import engine;
import game;

class Kalashnikov: GameObject {
  Transform tform;
  AudioAsset SHOT;
  AudioSource audio;

  override void setup() {
    layer = 30;

    tform = register(new Transform);
    tform.pos = Vec2(20, 40);
    tform.scale = Vec2(0.5, 0.5);

    auto ak47 = new ImageAsset("weapon/ak47.png");
    auto rend = register(new SpriteRenderer(ak47));

    SHOT = new AudioAsset("shot1.ogg");
    audio = register(new AudioSource(SHOT));
  }

  override void loop() {
    Vec2 vecm = (im.cusorPos - tform.pos).unit;
    vecm = vecm.rot(-45);
    vecm *= 500;
    if(im.mouseOnce(0)){
      register(new Missile(Missile.Type.CCCP, vecm, tform.pos));
      // vv bgm vv
      audio.volume(10);
      audio.play(1);
      //foreach(int i; 0..628) register(new Missile(Missile.Type.Divergence, Vec2(-cos(i * 0.01), sin(i * 0.01)), tform.pos));
    }
    // dbg(tform.rot = 90 * (atan(vecm.y / vecm.x)));
  }
}
