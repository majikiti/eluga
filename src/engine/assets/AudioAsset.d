module engine.assets.AudioAsset;

import std.string;
import sdl;
import sdl_mixer;
import engine;

class AudioAsset: Asset {
  Mix_Chunk* sound;
  
  this(string path){
    sound = Mix_LoadWAV(path.toStringz);
    import std;
    writeln(SDL_GetError.to!string);
    writeln(sound == null);
  }

  ~this(){
    Mix_FreeChunk(sound);
  }
}
