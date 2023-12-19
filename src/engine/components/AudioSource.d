module engine.components.AudioSource;

import std;
import engine;

class AudioSource: Component {
  private Player player;

  this(AudioAsset asset) {
    this.player = new Player(asset.sound);
  }

  void set(AudioAsset asset) {
    this.player = new Player(asset.sound);
  }

  void play(int loop = 0) { player.play(loop); }
  void volume(int vol) { player.volume(vol); }
  void pause() => player.pause;
  void resume() => player.resume;
}
