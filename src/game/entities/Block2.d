module game.entities.Block2;

import engine;
import game;

class Block2: GameObject {
  real time = 0;
  Transform tform;
  SpriteRenderer rend;
  BoxCollider col;
  this(Vec2 pos, Vec2 scale){
    tform = register(new Transform(Transform.Org.World));
    tform.pos = pos;
    tform.scale = scale;
    addTag("Ground");
  }

  override void setup() {
    auto block = new ImageAsset("block.png");
    rend = register(new SpriteRenderer(block));
    col = register(new BoxCollider(rend.size));
  }

  override void loop(){
    time += dur;
    if(time > 100){
      rend.active = !rend.active;
      col.active = !col.active;
      time = 0;
    }
  }
}
