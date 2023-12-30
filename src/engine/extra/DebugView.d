module engine.extra.DebugView;

import std;
import engine;

class DebugView: GameObject {
  Text lt;

  this() {
    layer = 254;
  }

  override void setup() {
    auto tform = register(new Transform); // for Text
    tform.pos = Vec2(8, 8);

    auto font = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 16);
    lt = register(new Text(font));
  }

  override void loop() {
    if(ctx.fps < 30) lt.setColor(255, 64, 64);
    else             lt.setColor(64, 255, 64);

    lt.text = [
      "DEBUG MODE\n",
      ctx.fps.to!string ~ " fps",
      everyone.length.to!string ~ " objects",
    ].join('\n');
  }
}
