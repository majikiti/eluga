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

  bool debugFrame = true;

  override void debugLoop() {
    if(!debugFrame) return;
    auto pos = go.component!Transform.renderPos;
    color(255, 0, 0);
    auto sc = worldScale.absVec;
    line(Vec2(pos.x, pos.y), Vec2(pos.x, pos.y + sc.y));
    line(Vec2(pos.x, pos.y + sc.y), Vec2(pos.x + sc.x, pos.y + sc.y));
    line(Vec2(pos.x + sc.x, pos.y + sc.y), Vec2(pos.x + sc.x, pos.y));
    line(Vec2(pos.x + sc.x, pos.y), Vec2(pos.x, pos.y));
  }

  // override bool collideBox(BoxCollider box);
}
