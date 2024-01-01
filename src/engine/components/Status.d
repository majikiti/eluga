module engine.components.Status;

import engine;

class Status: Component {
  int life;

  this(int life = 10){
    this.life = life;
  }
}
