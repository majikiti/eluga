module game.entities.TextBox;

import std;
import game;
import engine;

class TextBox : GameObject {
  Transform tform;
  TextAsset txa;
  Text tx;
  string content;

  this(string content, Vec2 initPos = Vec2(0, 0)) {
    this.content = content;
    tform = register(new Transform(Transform.Org.Local));
    tform.pos = initPos;
  }

  override void setup() {
    txa = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 40);
    tx = register(new Text(txa));
    tx.text = content;
  }
}
