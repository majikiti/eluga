module game.entities.Title;

import std;
import game;
import engine;

class Title : GameObject {
  Transform tform;
  TextAsset txa;
  Text tx;
  string content;

  this(string content) {
    this.content = content;
  }

  override void setup() {
    tform = register(new Transform);
    txa = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 40);
    tx = register(new Text(txa));
    tx.text = content;
  }
}