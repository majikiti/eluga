module game.entities.CoolText;

import std;
import engine;
import game;

class CoolText : GameObject {
  Transform tf;
  TextBox tb;
  CoolTextBack bg;

  this(string content) {
    tf = register(new Transform);
    tb = register(new TextBox(content));
    tb.component!Transform.pos = Vec2(windowSize.x - 100, 0);
    bg = register(new CoolTextBack);
    tf.pos = Vec2(-2 * windowSize.x, windowSize.y / 2);
  }

  override void loop() {
    if(abs(tf.pos.x + windowSize.x / 2) > 80) {
      tf.pos.x += 20;
    } else {
      tf.pos.x += 1;
    }
    if(!tf.isin(bg.component!SpriteRenderer.size) && tf.pos.x > 0) bye;
  }
}