module engine.components.Status;

import engine;

class Status: Component {
  int life;
  int damage;
  bool isDamaged = false;

  this(int life = 10, int damage = 1){
    this.life = life;
    this.damage = damage;
  }

  void getDamage() {
    life -= damage;
    isDamaged = true;
  }
}
