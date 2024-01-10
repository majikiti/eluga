module engine.components.Camera;

import std;
import engine;

// HikakinTVでカメラとか扱ったことあんまないけど
class Camera: Component {
  Vec2 pos; // カメラ絶対位置
  Vec2 size;
  Vec2 centre; // 画面サイズ分のバイアス
  GameObject fgo; // FocusGameObject

  struct Limit {
    Vec2 max;
    Vec2 min;
  }
  Limit lim;

  // この汚さどうにかしてくださいおねがいしますなんでもしますから
  this(Vec2 centre = Vec2(0, 0),
    Vec2 limax = Vec2(real.infinity, real.infinity),
    Vec2 limin = Vec2(-real.infinity, -real.infinity),
  ) {
    this.centre = centre;
    lim.max = limax;
    lim.min = limin;
  }

  void focus(GameObject fgo) {
    if(!fgo.has!Transform){
      warn("Camera: It has no-one of Transform", fgo);
      return;
    }
    this.fgo = fgo;
    return;
  }

  override void loop() {
    this.size = ctx.windowSize;
    this.centre = ctx.windowSize/2;
    if(fgo!is null){
      this.pos = fgo.component!Transform.pos - centre;
    }
    // 範囲外 カメラ もうやめて
    pos.x = max(min(pos.x, lim.max.x), lim.min.x);
    pos.y = max(min(pos.y, lim.max.y), lim.min.y);
  }
}
