module engine.core.media.Sound;

import std;
import sdl_mixer;

shared Mix_Chunk*[string] chunks;

class Sound {
  Mix_Chunk* data;

  this(string path) {
    // auto chunk = path in chunks;
    // if(chunk) {
    //   data = cast(Mix_Chunk*)chunk;
    //   return;
    // }
    data = Mix_LoadWAV(path.toStringz);
    // chunks[path] = cast(shared Mix_Chunk*)data;
  }
}
