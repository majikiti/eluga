module engine.components.Focus;

import engine;

class Focus: Component {
  ushort priority;
  bool enable;

  this(ushort priority, bool enable = true){
    this.priority = priority;
    this.enable = enable;
  }
}