module game.entities.UI;

import engine;
import game;
import std;

class UI: GameObject {
  Text text;
  size_t time;

  override void setup(){
    register(new Transform);
    component!Transform.pos = Vec2(200,200);
    auto font = new TextAsset("assets/PixelMplus-20130602/PixelMplus12-Regular.ttf",40);
    text = register(new Text(font));
  }

  override void loop(){
    time++;
    text.setText(time.to!string);
    dbg(time.to!string);
  }
}
