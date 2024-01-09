module game.entities.TimeLimitClock;

import std;
import engine;

class TimeLimitClock: GameObject {
  enum T_LIMIT = 10_000;

  Text timStr;
  ulong t_start; // started
  ulong t_remain() => T_LIMIT - min(T_LIMIT, uptime - t_start); // flooring 0 (unti overflow)

  override void setup() {
    register(new Transform);
    component!Transform.pos = Vec2(400,0);
    auto timerfont = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf",40);
    timStr = register(new Text(timerfont));
    t_start = uptime;
    timStr.text = t_remain.to!string;
  }

  override void loop() {
    timStr.text = (t_remain/1000).to!string;
    if(!t_remain) timeover;
  }

  void timeover() {
    return;
  }
}
