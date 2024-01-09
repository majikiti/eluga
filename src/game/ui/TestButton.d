module game.ui.TestButton;

import engine;
import game;

class TestButton : GameObject {
  this(){
    auto tform = register(new Transform);
    tform.scale = Vec2(0.2,0.2);
    auto img = new ImageAsset("block.png");
    register(new SpriteRenderer(img));
  }

  override void setup(){
    void delegate() event = (){
      import std;
      writeln("onclick");
    };
    auto btn = register(new Button(Vec2(256,256)));
    btn.leftEvent = event;
  }
}
