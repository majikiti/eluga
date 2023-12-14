module engine.components.BoxCollider;

import engine;

class BoxCollider: Component {
  Vec2 size;

  this(Vec2 size) {
    this.size = size;
  }
}
