module game.entities.BlockBlock;

import engine;
import game;
import sdl_mixer;

class BlockBlock : Block {
  override string dir() => "ground.png";
  
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
