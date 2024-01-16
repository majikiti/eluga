module engine.components.BoxCollider;

import engine;

class BoxCollider: Component, Collider {
  bool constable;
  bool isTrigger = false; // なんだ？
  Vec2 size = Vec2(1,1);

  this(Vec2 size, bool constable = false){
    this.size = size;
    this.constable = constable;
  }

  Vec2 worldScale() => Vec2(size.x * go.component!Transform.scale.x, size.y * go.component!Transform.scale.y);

 debug:
  bool debugFrame = false;

  override void debugLoop() {
    if(!debugFrame) return;
    auto pos = go.component!Transform.pos;
    color(255, 0, 0);
    line(Vec2(pos.x, pos.y), Vec2(pos.x, pos.y + worldScale.y));
    line(Vec2(pos.x, pos.y + worldScale.y), Vec2(pos.x + worldScale.x, pos.y + worldScale.y));
    line(Vec2(pos.x + worldScale.x, pos.y + worldScale.y), Vec2(pos.x + worldScale.x, pos.y));
    line(Vec2(pos.x + worldScale.x, pos.y), Vec2(pos.x, pos.y));
  }

  // override bool collideBox(BoxCollider box);
}
