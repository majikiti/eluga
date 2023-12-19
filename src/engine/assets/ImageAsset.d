module engine.assets.ImageAsset;

import engine;

class ImageAsset: Asset {
  Image image;

  this(string path) {
    surface = new Image(path);
  }

  auto surface() const => image.surface;
}
