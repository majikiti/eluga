module game.effects.Explosion;

import std;
import game;
import engine;

class Explosion : GameObject {
  ubyte[3] outside, inside, smoke;
  Transform tf;
  Timer tmr;
  ExpScatter[] exsc;

  real size;

  this(real size = 1,
      ubyte[3] outside = [255, 0, 0],
      ubyte[3] inside = [227, 81, 14],
      ubyte[3] smoke = [0, 0, 0]) {
    tf = register(new Transform(component!Transform.Org.Spawn, component!Transform.Zoom.Center));

    this.size = size;

    layer = -50;

    tmr = new Timer;
  }

  override void setup() {
    real phi = 0;
    // 外の爆破
    foreach(i; 0..cast(int)10*size){
      auto randomSrc = Random(cast(uint)tmr.cur);
      phi = uniform(-PI, PI, randomSrc);
      exsc ~= new ExpScatter(outside, Vec2(cos(phi), sin(phi)));
    }
    // 内の爆破
    foreach(i; 0..cast(int)10*size){
      auto randomSrc = Random(cast(uint)tmr.cur);
      phi = uniform(-PI, PI, randomSrc);
      exsc ~= register(new ExpScatter(inside, Vec2(cos(phi)*0.8, sin(phi)*0.8)));
    }
    // 煙
    foreach(i; 0..cast(int)10*size){
      auto randomSrc = Random(cast(uint)tmr.cur);
      phi = uniform(-PI, PI, randomSrc);
      exsc ~= register(new ExpScatter(smoke, Vec2(cos(phi)*0.5, sin(phi)*0.5)));
    }

    register(exsc);
  }

  override void loop() {
    if(exsc.length == 0) destroy;
  }
}