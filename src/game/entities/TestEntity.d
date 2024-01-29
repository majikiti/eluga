module game.entities.TestEntity;

import engine;
import game;

class TestEntity: GameObject{
  AudioAsset chunk;
  AudioSource audio;
  this(){
    chunk = new AudioAsset("explosion.ogg");
    audio = register(new AudioSource(chunk));
    audio.volume(50);
  }

  override void loop(){
    if(im.keyOnce('v')) audio.play(1);
    if(im.keyOnce('b')) destroy;
  }
}
