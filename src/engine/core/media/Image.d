module engine.core.media.Image;

import std;
import sdl;
import sdl_image;
import std;

class Image {
  private static SDL_Surface*[string] dataDict;
  private static int[string] dataNum;
  private string path;
  SDL_Surface* data;

  this(string path) {
    this.path = path;
    if(dataNum.get(path,0) > 0) {
      data = dataDict[path];
      dataNum[path]++;
    }else{
      data = IMG_Load(path.toStringz);
      dataDict[path] = data;
      dataNum[path] = 1;
    }
  }

  ~this() {
    dataNum[path]--;
    if(dataNum[path] <= 0){
      dataDict.remove(path);
      SDL_FreeSurface(data);
    }
  }
}
