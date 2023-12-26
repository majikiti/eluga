module engine.extra.DebugView;

import engine;

debug:

class DebugView: GameObject {
  Text text;

  override void setup() {
    auto font = new TextAsset("assets/PixelMplus-20130602/PixelMplus12-Regular.ttf", 32);
    text = register(new Text(font));
  }

  override void loop() {
    text.setText("asdf");
  }
}
