module engine.extra.DebugView;

import std;
import engine;

debug:

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
    lt.setColor(128, 255, 128);
  }

  override void loop() {
    lt.text = [
      "DEBUG MODE\n",
      ctx.fps.to!string ~ " fps",
      everyone.length.to!string ~ " objects",
    ].join('\n');
  }
}
