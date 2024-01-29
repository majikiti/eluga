module game.entities.MakeDonMap;

import engine;
import game;

class MakeDonMap : GameObject {
  Don!"Patio.don" don;

  Transform tform;

  Vec2 pxSize;

  Vec2fixed delta;

  this(Vec2 pxSize){
    tform = register(new Transform);
    this.pxSize = pxSize;
    delta = don.don.delta;
    makeStage;
  }

  void makeObj(long i, Vec2 pos){
    switch(i){
      case 0:
        register(new Hero);
        break;
      case 1:
        register(new BlockBlock(pos, Vec2(1/4.0,1/4.0)));
        break;
      case 2:
        register(new BlockBrick(pos, Vec2(1/4.0,1/4.0)));
        break;
      case 3:
        register(new BlockHatena(pos, Vec2(1/4.0,1/4.0)));
        break;
      case 4:
        register(new BlockTube(pos, Vec2(1/4.0,1/4.0)));
        break;
      case 5:
        register(new BlockTube(pos, Vec2(1/4.0,1/4.0)));
        break;
      case 6:
      case 7:
        register(new Block(pos, Vec2(1/4.0,1/4.0)));
        break;
      case 8:
        register(new Enemy1(pos));
        break;
      case 9:
        register(new Enemy2(pos));
        break;
      case 10:
        register(new Enemy3(pos));
        break;
      case 11:
        register(new Enemy4(pos));
        break;
      case 12:
        register(new Enemy5(pos));
        break;
      case 13:
        register(new Boss(pos));
        break;
      default:
        break;
    }
  }

  void makeStage(){
    auto mat = don.don.mat;
    foreach(i, p; mat){
      foreach(j, q; p){
        makeObj(q, Vec2(j * pxSize.x + delta.x, i * pxSize.y + delta.y));
      }
    }
  }
}
