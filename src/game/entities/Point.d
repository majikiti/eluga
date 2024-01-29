module game.entities.Point;

import std;
import engine;
import game;

class Point: GameObject {
  Transform tf;
  Text pntStr;

  override void setup() {
    tf = register(new Transform(tf.Org.Local));
    component!Transform.pos = Vec2(200,0);
    auto pointfont = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf",40);
    pntStr = register(new Text(pointfont));
    pointDisp;
  }

  override void loop() {
    pointDisp;
  }

  void pointDisp() {pntStr.text = gm.point.to!string;}
}