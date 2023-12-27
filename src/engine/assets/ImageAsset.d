module engine.assets.ImageAsset;

import engine;

class ImageAsset: Asset {
  private Image image;

  this(string path) {
    image = new Image(locateAsset(path));
  }

  auto surface() => image.data;
}
