module game.entities.Point;

import std;
import engine;

class Point: GameObject {
  Text pntStr;
  ulong point;

  override void setup() {
    register(new Transform);
    component!Transform.pos = Vec2(200,0);
    auto pointfont = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf",40);
    pntStr = register(new Text(pointfont));
    pntStr.text = point.to!string;
  }

  override void loop() {
    pntStr.text = point.to!string;
  }
}