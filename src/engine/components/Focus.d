module engine.components.Focus;

import engine;

class Focus: Component {
  private ushort _priority;
  bool enable;

  ushort priority() => this._priority;

  this(ushort priority, bool enable = true){
    this._priority = priority;
    this.enable = enable;
  }
}