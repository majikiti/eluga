module engine.core.media.Sound;

import sdl_mixer;

shared Mix_Chunk*[string] chunks;

class Sound {
  package const Mix_Chunk* data;

  this(string path) {
    auto chunk = path in chunks;
    if(chunk) {
      this.data = chunk;
      return;
    }
    data = Mix_LoadWAV(path.toStringz);
  }
}
