module game.entities.TimeLimitClock;

import std;
import engine;
import game;

class TimeLimitClock: GameObject {
  Text timStr;

  override void setup() {
    register(new Transform(Transform.Org.Local));
    component!Transform.pos = Vec2(400,0);
    auto timerfont = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf",40);
    timStr = register(new Text(timerfont));
  }

  override void loop() {
    tmrDisp;
    if(gm.lefttime < 100_000) {
      timStr.setColor(220, 0, 0);
    }
  }

  void tmrDisp() {timStr.text = (gm.lefttime / 1_000).to!string;}
}
