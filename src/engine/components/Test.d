module engine.components.Test;

import std;
import engine;
import std.math;

class Test: Component {
  real g,c,k,m,t;
  real[] y;
  int num = 10000;
  this(){
    g = 9.81;
    k = 1.2;
    m = 1;
    t = 0;
    c = -k/m;
    for(int i = 0; i<num; i++){
      y ~= 0;
    }
    reset();
  }

  void reset(){
    t = 0;
    foreach(ref i; y) i = 0;
    for(int i = 0; i<num-2; i++)y[i] = g * c ^^ (num - 3 - i);
    y[0] = g * c ^^ (num - 3);
  }

  override void loop(){
    if(go.ctx.im.keyOnce('r')){
      dbg("reset");
      reset();
    }
    auto dur = go.ctx.dur/256.0;
    for(int i = 1; i < num; i++){
      y[i] += y[i-1] * dur;
    }
    t += dur;
    log(y[num-1]," ",y[num-2]," ",(m*g/k)*(1-exp(c*t)));
    // log("[y:",y,", v:",v,", a:",a,", da:",da,", dda:",dda,", ddda:",ddda,", dur:",dur,"]");
  }
}
