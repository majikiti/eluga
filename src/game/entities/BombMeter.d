module game.entities.BombMeter;

import engine;
import game;

class BombMeter : GameObject {
  Transform tf;
  ImageBox[] ib;
  TextBox tb;

  this(){
    tf = register(new Transform(tf.Org.Local));
    tf.pos = Vec2(700, 0);
    foreach(i; 0..3) ib ~= register(new ImageBox("bomb.png"));
    foreach(i, ref imbx; ib) {
      imbx.component!Transform.pos = Vec2(i*100, 0);
      imbx.component!Transform.scale = Vec2(0.2, 0.2);
    }
    tb = register(new TextBox("+いっぱい", Vec2(300, 0)));
  }

  override void loop() {
    foreach(i, ref imbx; ib){
      if(i < gm.heroStatus.haveObj.length) imbx.component!SpriteRenderer.enable = true;
      else imbx.component!SpriteRenderer.enable = false;
    }
    tb.component!Text.enable = (gm.heroStatus.haveObj.length > 3);
  }
}