module game.ui.TileMap;

import engine;
import game;

class TileMap : GameObject {
  GameObject[] tile;
  int hNum = 100,wNum = 100;

  this(){
    register(new Transform);
  }

  override void setup(){
    auto img = new ImageAsset("block.png");
    for(int r = 0; r < hNum; r++){
      for(int c = 0; c < wNum; c++){
        tile ~= register(new Tile(Vec2(256 * 0.1 * r, 256 * 0.1 * c), img));
      }
    }
  }
}
