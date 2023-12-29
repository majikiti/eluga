module engine.components.BoxCollider;

import engine;

class BoxCollider: Component, Collider {
  bool constable;
  Vec2 size;

  this(bool constable = false){
    this.constable = constable;
  }

  override void setup() {
    if(!go.parent.has!Transform) return;
    auto trf = go.parent.component!Transform;
    this.size = trf.scale;
  }

  override void loop() {
    if(!go.parent.has!Transform || constable) return;
    auto trf = go.parent.component!Transform;
    this.size = trf.scale;
  }

  // override bool collideBox(BoxCollider box);
}
