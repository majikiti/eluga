module game.entities.TextBox;

import std;
import game;
import engine;

class TextBox : GameObject {
  Transform tform;
  TextAsset txa;
  Text tx;
  string content;

  bool isFocus;

  this(string content, Vec2 initPos = Vec2(0, 0), bool isFocus = false) {
    this.content = content;
    tform = register(new Transform(Transform.Org.Local));
    tform.pos = initPos;
    this.isFocus = isFocus;
  }

  override void setup() {
    if(isFocus) register(new Focus(10));
    txa = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 40);
    tx = register(new Text(txa));
    tx.text = content;
  }
}
