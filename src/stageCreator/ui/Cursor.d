module stageCreator.ui.Cusor;

import engine;
import stageCreator;

class Cusor : GameObject {
  this(){
    auto tform = register(new Transform);
    tform.scale = Vec2(0.01,0.01);
    auto texture = new ImageAsset("21468.png");
    register(new SpriteRenderer(texture));
  }

  override void loop(){
    auto tform = component!Transform;
    tform.pos = im.cusorPos;
  }
}
