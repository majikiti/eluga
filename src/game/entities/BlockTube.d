module game.entities.BlockTube;

import engine;
import game;
import sdl_mixer;

class BlockTube : Block {
  // override string dir() => "notxtre.png";
  override string dir() => "tube.png"; // fixing...
  
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
