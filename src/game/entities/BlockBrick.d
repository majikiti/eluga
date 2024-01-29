module game.entities.BlockBrick;

import engine;
import game;
import sdl_mixer;

class BlockBrick : Block {
  override string dir() => "brick.png";
  
  this(Vec2 pos, Vec2 scale){
    super(pos, scale);
  }

  override void setup() {
    super.setup;
  }

  override void loop() {
    super.loop;
  }
}