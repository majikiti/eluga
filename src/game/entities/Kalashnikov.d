module game.entities.Kalashnikov;

import std;
import sdl_mixer;
import engine;
import game;

class Kalashnikov: GameObject {
  Transform tform;
  AudioAsset SHOT;
  AudioSource audio;

  Vec2 fixvec = Vec2(80,50);

  Vec2 vecm;

  override void setup() {
    layer = 30;

    tform = register(new Transform(Transform.Org.Local));
    tform.pos = Vec2(20, 40);
    tform.scale = Vec2(0.5, 0.5);

    auto ak47 = new ImageAsset("weapon/ak47.png");
    auto rend = register(new SpriteRenderer(ak47));

    SHOT = new AudioAsset("shot1.ogg");
    audio = register(new AudioSource(SHOT));
  }

  override void loop() {
    vecm = (im.cusorPos - tform.renderPos).unit;
    vecm *= 100;
    if(im.mouseOnce(0) && !(dm.debugMode && dm.rapidFire)){
      register(new Missile(Missile.Type.CCCP, vecm, tform.worldPos));
      // vv bgm vv
      audio.volume(10);
      audio.play(1);
      //foreach(int i; 0..628) register(new Missile(Missile.Type.Divergence, Vec2(-cos(i * 0.01), sin(i * 0.01)), tform.pos));
    }
  }

  debug:
  override void debugLoop() {
    if(!dm.debugMode) return;
    if(im.mouse(0) && (dm.debugMode && dm.rapidFire)){
      register(new Missile(Missile.Type.CCCP, vecm, tform.worldPos));
      // vv bgm vv
      audio.volume(10);
      audio.play(1);
      //destroy; // SDL_mixer SIGSERV test
      
      //foreach(int i; 0..628) register(new Missile(Missile.Type.Divergence, Vec2(-cos(i * 0.01), sin(i * 0.01)), tform.pos));
    }
    tform.rot = 180 * (atan2(vecm.y, vecm.x) / PI);
  }
}
