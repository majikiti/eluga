module engine.core.media.Player;

import sdl_mixer;
import engine;

class Player {
  private Sound sound;
  private int chan = -1;

  this(Sound sound) {
    this.sound = sound;
  }

  ~this(){
    if(chan != -1 && ctx.running) Mix_HaltChannel(chan);
    chan = -1;
  }

  int play(int loop = 1) => chan = Mix_PlayChannel(chan, sound.data, loop);
  int volume(int vol) => chan == -1 ? -1 : Mix_Volume(chan, vol);
  void pause() => Mix_Pause(chan);
  void resume() => Mix_Resume(chan);
  bool playing() => chan == -1 ? false : Mix_Playing(chan) != 0;
  bool paused() => chan == -1 ? false : Mix_Paused(chan) != 0;

  void chunkUpdate(){
    if(!playing) chan = -1;
  }
}
