module engine.assets.AudioAsset;

import engine;

class AudioAsset: Asset {
  Sound sound;
  Player player;

  this(string path) {
    sound = new Sound(locateAsset(path));
  }
}
