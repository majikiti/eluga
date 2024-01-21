module engine.core.media.Player;

import sdl_mixer;
import engine;

class Player {
  private Sound sound;
  private int chan = -1;

  this(Sound sound) {
    this.sound = sound;
  }

  int play(int loop) => chan = Mix_PlayChannel(chan, sound.data, loop);
  int volume(int vol) => Mix_Volume(chan, vol);
  void pause() => Mix_Pause(chan);
  void resume() => Mix_Resume(chan);
  bool playing() => Mix_Playing(chan) != 0;
  bool paused() => Mix_Paused(chan) != 0;
}
