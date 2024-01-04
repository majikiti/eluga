module game.entities.LifeIndicator;

import engine;
import game;

class LifeIndicator: GameObject {
  Transform tform;
  SpriteRenderer lifein;

  this(){

  }

  override void setup() {
    tform = register(new Transform);

  }
}