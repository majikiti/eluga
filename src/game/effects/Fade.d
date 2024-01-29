module game.effects.Fade;

import std;
import game;
import engine;

class Fade: GameObject {
  Transform tform;
  SpriteRenderer sr;

  WindowParam win;
  Timer tmr;

  bool isDisplay = false, isChanging = false;
  uint fadetime;
  ubyte[3] color;
  private ubyte changeTo = 0;

  this(ubyte[3] color = [0, 0, 0], uint fadetime = 1, ubyte tp = 0) {
    layer = -80;
    ubyte[4] cbuf = color ~ tp;
    win = new WindowParam;
    tmr = new Timer;
    tform = register(new Transform(tform.Org.World));
    sr = register(new SpriteRenderer(windowSize, cbuf));
    this.color = color;
    this.fadetime = fadetime;
    sr.setOpac(tp);
  }

  bool display(bool d){
    changeTo = d ? 0 : 255;
    isChanging = true;
    return (changeTo == 255);
  }

  bool swap(){
    changeTo = (changeTo == 255) ? 0 : 255;
    isChanging = true;
    return (changeTo == 255);
  }

  void show(){
    changeTo = 0;
    isChanging = true;
  }

  void hide(){
    changeTo = 255;
    isChanging = true;
  }

  void tpSet(ubyte tp) {
    sr.setOpac(tp);
  }

  override void loop() {
    if(tmr.cur >= fadetime){
      tmr.reset;
      if(!isChanging) goto afterfade; // 表示と変化先が等しい(変化済み)
      (changeTo == 0) ? sr.setOpac(sr.opac - 3) : sr.setOpac(sr.opac + 3);
      if(changeTo == sr.opac){
        finish;
      }
    }
    //dbg(sr.colorArr);
    afterfade:
  }

  void finish() {
    isChanging = false;
  }
}
