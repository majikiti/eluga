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

  int play(bool loops = false){
    channel = Mix_PlayChannel(channel, sound,cast(int)loops);
    return channel == -1 ? -1 : 0;
  }

  void rewind(){
    Mix_RewindMusic();
  }

  int volume(int vol){
    return Mix_VolumeMusic(vol);
  }

  void pause(){
    Mix_PauseMusic();
  }

  void resume(){
    Mix_ResumeMusic();
  }

  bool isPlaying(){
    return Mix_PlayingMusic() > 0;
  }

  bool paused(){
    return cast(bool)Mix_PausedMusic();
  }
}
