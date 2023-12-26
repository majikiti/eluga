module engine.components.BoxCollider;

import engine;

class BoxCollider: Component, Collider {
  Vec2 size;

  this(Vec2 size) {
    this.size = size;
  }

  // override bool collideBox(BoxCollider box);
}
