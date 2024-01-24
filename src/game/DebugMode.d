module game.DebugMode;

import engine;
import game;

class DebugMode : GameObject {
  Text lt;

  this() {
    layer = 254;
  }

  override void setup() {
    auto tform = register(new Transform(Transform.Org.Real));
    tform.pos = Vec2(windowSize.x - 100, 8);

    auto font = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 16);
    lt = register(new Text(font));
    lt.setColor(255, 64, 64);
    lt.text = "DebugMode";
    lt.active = false;
  }

  debug:
  override void debugLoop() {
    if(im.keyOnce('p')){
      gm.debugFrame = !gm.debugFrame;
    }
    lt.active = gm.debugFrame;
    if(gm.debugFrame) dbg("active");
  }
}
