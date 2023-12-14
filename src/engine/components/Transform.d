module engine.components.Transform;

import engine;

class Transform: Component {
  // 相対座標か絶対座標か
  enum Org{
    World,
    Local,
  }

  private Org org;
  Vec2 pos = Vec2(0,0);
  Vec2 worldPos = Vec2(0,0);
  real rot = 0;
  Vec2 scale = Vec2(1,1);

  this(Org worldType = Org.Local){
    org = worldType;
  }

  auto translate(Vec2 d) => pos += d;

  override void loop(){
    auto parent = go.parent;
    auto pPos = parent.component!Transform;
    worldPos = pos;
    if(org == Org.Local && pPos !is null) worldPos += pPos.worldPos;
  }
}
