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
  private ubyte tp = 255, changeTo = 0;

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

  this(ubyte[3] color = [0, 0, 0], uint fadetime = 1) {
    this.color = color;
    this.fadetime = fadetime;
    tmr = new Timer;
  }

  override void setup() {
    tform = register(new Transform);
    win = register(new WindowParam);
    ubyte[4] ubyuf = color ~ 255;
    dbg(ubyuf, ", ", ubyuf.length);
    sr = register(new SpriteRenderer(win.size, ubyuf));
  
    //win = register(new WindowParam);
    //tmr = register(new Timer);
  }

  override void loop() {
    if(tmr.cur >= fadetime){
      if(!isChanging) goto afterfade; // 表示と変化先が等しい(変化済み)
      (changeTo == 0) ? tp-=4 : tp+=4;
      if(changeTo == tp){
        isChanging = false;
      }
      tmr.reset;
    }
    sr.colorArr = color ~ tp;
    dbg(sr.colorArr);
    afterfade:
  }
}