module game.entities.ImageBox;

import std;
import game;
import engine;

class ImageBox : GameObject {
  Transform tform;
  ImageAsset ima;
  SpriteRenderer sr;

  this(string dir) {
    ima = new ImageAsset(dir);
  }

  override void setup() {
    tform = register(new Transform);
    sr = register(new SpriteRenderer(ima));
  }
}