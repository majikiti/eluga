module engine.core.media.Player;

import sdl_mixer;
import engine;

class Player {
  private Sound sound;
  private int chan = -1;

  this(Sound sound) {
    this.sound = sound;
  }

  int play(int loop) => notReady ? -1 : (chan = Mix_PlayChannel(chan, sound.data, loop));
  int volume(int vol) => notReady ? -1 : Mix_Volume(chan, vol);
  void pause() => notReady ? null : Mix_Pause(chan);
  void resume() => notReady ? null : Mix_Resume(chan);
  bool playing() => notReady ? false : Mix_Playing(chan) != 0;
  bool paused() => notReady ? false : Mix_Paused(chan) != 0;

  private bool notReady() => chan == -1;
}
