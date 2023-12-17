module game.stages.titleScene.TextBox;

import engine;
import game;
import core.math;

class TextBox: GameObject {
  Transform transform;
  TextAsset font;
  Text text;
  private string t;
  private real flame = 0;

  this(string text){
    t = text;
  }

  override void setup(){
    transform = register(new Transform);
    font = new TextAsset("assets/PixelMplus-20130602/PixelMplus12-Regular.ttf",40);
    text = register(new Text(font));
    text.setText(t);
    auto window = register(new Window);
    component!Transform.pos = window.size()/2;
  }

  override void loop(){
    transform.rot+=0.1;
    transform.scale = Vec2(1, 1) * (2 + sin(flame / 2048));
    flame++;
  }
}
