module game.stages.title.TextBox;

import engine;
import game;
import core.math;

class TextBox: GameObject {
  private string s;
  private real flame = 0;

  this(string s) {
    this.s = s;
  }

  override void setup() {
    auto font = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 40);
    auto text = register(new Text(font));
    text.text = s;

    auto tform = register(new Transform);
    auto window = register(new Window);
    tform.pos = window.size / 2;
  }

  override void loop() {
    auto tform = component!Transform;
    tform.rot += 0.1;
    tform.scale = Vec2(1, 1) * (2 + sin(flame / 2048));
    flame++;
  }
}
