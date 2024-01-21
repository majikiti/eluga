module engine.components.Status;

import engine;

class Status: Component {
  const int maxlife;
  int life;
  int damage;
  bool isDamaged = false;
  bool willDead = false;

  this(int maxlife = 10, int damage = 1){
    this.maxlife = maxlife;
    this.life = maxlife;
    this.damage = damage;
  }

  void getDamage() {
    life -= damage;
    isDamaged = true;
  }
}
