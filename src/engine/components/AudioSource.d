module engine.components.AudioSource;

import std;
import engine;

class AudioSource: Component {
  private Player player;
  private bool playing;

  this(AudioAsset asset) {
    this.player = new Player(asset.sound);
  }

  void set(AudioAsset asset) {
    this.player = new Player(asset.sound);
  }

  override void bye() {
    playing = player.playing;
    if(playing) pause;
  }

  override void resurrection() {
    if(playing) play;
  }

  void play(int loop = 0) { player.play(loop); }
  void volume(int vol) { player.volume(vol); }
  void pause() => player.pause;
  void resume() => player.resume;

  override void loop(){
    player.chunkUpdate;
  }
}
