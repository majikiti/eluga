module engine.components.Transform;

import engine;

class Transform: Component {
  // 相対座標か絶対座標か
  enum Org{
    World,
    Local,
  }

  // 一般座標系
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
    worldPos = pos;
    
    auto parent = go.parent;
    if(!parent.has!Transform) return;

    // 親位置
    auto pPos = parent.component!Transform;
    if(org == Org.Local) worldPos += pPos.worldPos;
  }

  // カメラ座標系
  Vec2 campos() {
    auto gobj = go;
    while(!gobj.has!Camera) gobj = gobj.parent; // Camera持ちまで登る
    auto retpos = this.pos  - gobj.component!Camera.pos ;
    return retpos;
  }

  Vec2 camscale(){
    // やりたくありません
    return scale;
  }
}
