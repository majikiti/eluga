module engine.assets.ImageAsset;

import engine;

class ImageAsset: Asset {
  private Image image;
  private string id;

  this(string path) {
    image = new Image(locateAsset(path));
    id = path;
  }

  auto surface() => image.data;

  auto texture() {
    static Texture[typeof(id)] cache;
    if(id in cache) return cache[id];
    return cache[id] = new Texture(ctx.r, surface);
  }
}
