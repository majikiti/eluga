module game.entities.Block;

import engine;
import game;
import sdl_mixer;

class Block: GameObject {
  int life;
  real time = 0;
  Transform tform;

  this(Vec2 pos, Vec2 scale){
    tform = register(new Transform(Transform.Org.World));
    tform.pos = pos;
    tform.scale = scale;
    tags["Ground"] = true;
  }

  override void setup() {
    auto block = new ImageAsset("block.png");
    auto rend = register(new SpriteRenderer(block));
    register(new BoxCollider(rend.size));
  }
}
