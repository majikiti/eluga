module engine.components.Focus;

import engine;

class Focus: Component {
  // 1 - ushort.max で付番してね
  // 番号が若い順でフォーカスされるよ
  // enable = true のときフォーカスが有効化されます
  private ushort _priority;
  bool enable;

  ushort priority() => this._priority;

  this(ushort priority, bool enable = true){
    this._priority = priority;
    this.enable = enable;
  }
}