module game.entities.BlockHatena;

import std;
import engine;
import game;
import sdl_mixer;

class BlockHatena : Block {
  override string dir() => "hatena_block.png";
  
  this(Vec2 pos, Vec2 scale){
    super(pos, scale);
  }

  override void setup() {
    super.setup;
  }

  override void loop() {
    super.loop;
  }

  // どうにかしてハテナブロック動かしたい……動かしたい……!動かしたい……!!動かしたいぃぃい!!!!!………ﾌﾞｰﾝ
  //override void collide(GameObject go) {
  //  if(go.getTag("Hero")){
  //    dbg("Halloooo!!");
  //    if(abs(go.component!RigidBody.v.y) < 0.1) {
  //      dbg("Oh! That's mental.");
  //      auto ia = new ImageAsset("hatena_block_superwhat.png");
  //      rend = register(new SpriteRenderer(ia));
  //    }
  //  }
  //}
}