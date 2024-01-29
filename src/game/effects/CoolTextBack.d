module game.effects.CoolTextBack;

import std;
import game;
import engine;

class CoolTextBack : GameObject {
  Transform tf;
  SpriteRenderer sr;

  this() {
    tf = register(new Transform(tf.Org.Local));
    sr = register(new SpriteRenderer(windowSize * Vec2(2, 0.125), [0x00, 0xbd, 0xe5, 127]));
  }
}