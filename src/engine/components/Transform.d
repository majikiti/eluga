module engine.components.Transform;

import std;
import engine;

class Transform: Component {
  // 左端基準ズームか中心基準ズームか
  enum Zoom{
    Corner,
    Center,
  }

  // 相対座標か絶対座標か
  enum Org {
    Real,
    World,
    Local,
  }

  // 一般座標系
  private Zoom zoom;
  private Org org;
  Vec2 pos, renderPos;
  real rot = 0;
  Vec2 scale = Vec2(1,1);

  auto worldPos() {
    switch(org) {
      case Org.World: return pos;
      case Org.Local: {
        if(!go.parent.has!Transform) err("parent (", go.parent, ") doesn't have Transform!");
        auto ptform = go.parent.component!Transform;
        return ptform.worldPos + pos;
      }
      default:
        throw new Error(org.to!string ~ " cannot convert to worldpos");
    }
  }

  this(Org worldType = Org.World) {
    org = worldType;
  }

  override void loop() {
    final switch(org) {
      case Org.Real:
        renderPos = pos;
        break;

      case Org.World:
      case Org.Local:
        renderPos = worldPos - ctx.camera.pos;
        break;
    }
  }

  // Obj範囲内にWinのどっちかの端があるかという考え方
  bool isin(Vec2 sz) {
    auto c = ctx.camera;
    return !((pos.x > c.pos.x + c.size.x) || (pos.x + sz.x < c.pos.x))
        && !((pos.y + sz.y < c.pos.y) || (pos.y > c.pos.y + c.size.y));
  }
}
