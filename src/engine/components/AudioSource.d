module engine.components.AudioSource;

import sdl;
import sdl_mixer;
import engine;
import std.algorithm.comparison;


class AudioSource: Component {

  private int channel = -1;
  Mix_Chunk* sound;

  this(AudioAsset asset){
    sound = asset.sound;
  }

  void set(AudioAsset asset){
    sound = asset.sound;
  }

  int play(int loops = 0){
    channel = Mix_PlayChannel(channel, sound, loops);
    return channel == -1 ? -1 : 0;
  }

  int volume(int vol){
    return Mix_Volume(channel, vol);
  }

  void pause(){
    channel.Mix_Pause;
  }

  void resume(){
    Mix_Resume(channel);
  }

  bool isPlaying(){
    return channel.Mix_Playing > 0;
  }

  bool paused(){
    return cast(bool)channel.Mix_Paused;
  }
}
