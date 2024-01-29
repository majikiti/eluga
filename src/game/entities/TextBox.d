module game.entities.TextBox;

import std;
import game;
import engine;

class TextBox : GameObject {
  Transform tform;
  TextAsset txa;
  Text tx;
  string content;

  Vec2 initPos;
  real pmax = 20, theta = 0;

  bool isFocus;
  bool flugzeug; // ふ〜よふよ

  this(string content, Vec2 initPos = Vec2(0, 0), bool flugzeug = false) {
    this.content = content;
    tform = register(new Transform(Transform.Org.Local));
    tform.pos = initPos;
    this.flugzeug = flugzeug;
    this.initPos = initPos;
  }

  override void setup() {
    if(isFocus) register(new Focus(10));
    txa = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 40);
    tx = register(new Text(txa));
    tx.text = content;
  }

  override void loop() {
    if(flugzeug) {
      tform.pos.y = initPos.y + pmax * sin(theta);
      theta += 0.017;
    }
  }
}
