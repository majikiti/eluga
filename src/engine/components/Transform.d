module engine.components.Transform;

import std;
import engine;

class Transform: Component {
  // 左端基準ズームか中心基準ズームか
  enum Zoom{
    Corner,
    Center,
  }

  // 相対座標か絶対座標か初期位置のみ相対座標か
  enum Org {
    Real,
    World,
    Local,
    Spawn, // ToDo: make SpawnOrg
  }

  // 一般座標系
  private Zoom zoom;
  private Org org;
  Vec2 pos, renderPos;
  real rot = 0;
  Vec2 scale = Vec2(1,1);

  private bool looped;

  auto worldPos() {
    switch(org) {
      case Org.World: return pos;
      case Org.Local:
      case Org.Spawn: {
        auto ptform = go.parent.has!Transform
          ? go.parent.component!Transform
          : go.parent.register(new Transform);
        return ptform.worldPos + pos;
      }
      default:
        throw new Error(org.to!string ~ " cannot convert to worldpos");
    }
  }

  this(Org worldType = Org.Local, Zoom zoomType = Zoom.Corner){
    zoom = zoomType;
    org = worldType;
  }

  override void loop() {
    final switch(org) {
      case Org.Real:
        renderPos = pos;
        break;
      case Org.World:
      case Org.Local:
      case Org.Spawn:
        renderPos = worldPos - ctx.camera.pos;
        break;
    }
  }

  // Obj範囲内にWinのどっちかの端があるかという考え方
  bool isin(Vec2 sz) {
    auto c = ctx.camera;
    return !((pos.x > c.pos.x + c.size.x) || (pos.x > c.pos.x + c.size.x))
        && !((pos.y + sz.y < c.pos.y) || (pos.y > c.pos.y + c.size.y));
  }
}
