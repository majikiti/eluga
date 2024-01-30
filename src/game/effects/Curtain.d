module game.effects.Curtain;

import std;
import game;
import engine;

alias F = void delegate();

class Curtain: Fade {
  F f;

  this(ubyte[3] color = [0, 0, 0], uint fadetime = 1, ubyte tp = 0) {
    super(color, fadetime, tp);
    layer = 123;
  }

  override void loop() {
    super.loop;
  }

  void open() {
    tpSet(255);
    show;
  }

  void close(F f = null) {
    tpSet(0);
    this.f = f;
    hide;
  }

  override void finish(bool finishedIn) {
    super.finish(finishedIn);
    if(f !is null && finishedIn) f();
  }
}