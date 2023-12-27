module engine.extra.DebugView;

import std;
import engine;

debug:

class DebugView: GameObject {
  Text lt;

  override void setup() {
    auto tform = register(new Transform); // for Text
    tform.pos = Vec2(8, 8);

    auto font = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 16);
    lt = register(new Text(font));
  }

  override void loop() {
    lt.text = [
      "DEBUG MODE\n",
      ctx.fps.to!string ~ " fps",
      everyone.length.to!string ~ " objects",
    ].join('\n');
  }
}
