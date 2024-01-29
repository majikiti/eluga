module engine.components.Focus;

import engine;

class Focus: Component {
  // 1 - ushort.max で付番してね
  // 番号が若い順でフォーカスされるよ
  // enable = true のときフォーカスが有効化されます
  // follow = false にすると固定カメラになります
  private ushort _priority;
  bool enable;
  bool follow;

  ushort priority() => this._priority;

  this(ushort priority, bool enable = true, bool follow = true){
    this._priority = priority;
    this.enable = enable;
    this.follow = follow;
  }
}
