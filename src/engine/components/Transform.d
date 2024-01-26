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
  Zoom zoom;
  private Org org;
  Vec2 pos, renderPos, initPos;
  real rot = 0;
  Vec2 scale = Vec2(1,1);

  private bool looped;

  Transform getPtform() => go.parent.has!Transform
          ? go.parent.component!Transform
          : go.parent.register(new Transform);

  auto worldPos() {
    switch(org) {
      case Org.Spawn:
      case Org.World: return pos;
      case Org.Local: {
        auto ptform = getPtform;
        return ptform.worldPos + pos;
      }
      default:
        throw new Error(org.to!string ~ " cannot convert to worldpos");
    }
  }

  this(Org worldType = Org.World, Zoom zoomType = Zoom.Corner){
    zoom = zoomType;
    org = worldType;
  }

  override void setup() {
    pos = initPos;
  }

  override void loop() {
    if(!looped && org == Org.Spawn) {
      looped = true;
      auto ptform = getPtform;
      pos = ptform.worldPos + initPos;
    }

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
    return !((worldPos.x > c.pos.x + c.size.x) || (worldPos.x + sz.x < c.pos.x))
        && !((worldPos.y + sz.y < c.pos.y) || (worldPos.y > c.pos.y + c.size.y));
  }

  bool hidein(Vec2 sz, int range) {
    auto c = ctx.camera;
    return !((worldPos.x > c.pos.x + c.size.x + range) || (worldPos.x + sz.x + range < c.pos.x))
        && !((worldPos.y + sz.y + range < c.pos.y) || (worldPos.y > c.pos.y + c.size.y + range));
  }
}
