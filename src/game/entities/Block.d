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
    addTag("Ground");
  }

  override void setup() {
    auto rend = register(new SpriteRenderer(Vec2(256, 256)));
    register(new BoxCollider(rend.localSize.absVec));
  }

  override void collide(GameObject go) {
    if(go.getTag("Missile")) register(new Dust);
  }
}
