module engine.components.Camera;

import engine;

// HikakinTVでカメラとか扱ったことあんまないけど
class Camera: Component {
  Vec2 pos; // カメラ絶対位置
  real scale; // 1.0Lで座標系と1:1対応、値を大きくすると広角に
  Vec2 focusPoint; // カメラ内部のフォーカス指定(デフォルト(0, 0)で中央)
  GameObject fgo;
  real theta;

  this(Vec2 pos = Vec2(0, 0), real scale = 1.0, Vec2 focusPoint = Vec2(0, 0)) {
    this.pos = pos;
    this.scale = scale;
    this.focusPoint = focusPoint;
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
    if(fgo!is null) this.pos = fgo.component!Transform.pos;

    // 仮工事田所小路
    pos = Vec2(100*cos(theta), 100*sin(theta));
    theta += 0.01;
  }
}