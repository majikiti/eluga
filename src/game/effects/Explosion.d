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

    this.outside = outside;
    this.inside = inside;
    this.smoke = smoke;

    layer = -50;

    tmr = new Timer;
  }

  override void setup() {
    auto randomSrc = Random(cast(uint)tmr.cur);
    real theta = 0, dtheta = 0, ranlen;
    // 外の爆破
    theta = 0;
    dtheta = (2*PI)/(30*size);
    foreach(i; 0..cast(int)30*size){
      ranlen = uniform(0.85, 1.25, randomSrc);
      exsc ~= register(new ExpScatter(outside, Vec2(cos(theta), -sin(theta)) * ranlen));
      theta += dtheta;
    }
    // 内の爆破
    theta = 0;
    dtheta = (2*PI)/(15*size);
    foreach(i; 0..cast(int)15*size){
      ranlen = uniform(0.85, 1.25, randomSrc);
      exsc ~= register(new ExpScatter(inside, Vec2(cos(theta), sin(theta)) * 0.8 * ranlen));
      theta += dtheta;
    }
    // 煙
    theta = 0;
    dtheta = (2*PI)/(5*size);
    foreach(i; 0..cast(int)5*size){
      ranlen = uniform(0.85, 1.25, randomSrc);
      exsc ~= register(new ExpScatter(smoke, Vec2(cos(theta), sin(theta)) * 2 * ranlen));
    }
  }

  override void loop() {
    if(!has!ExpScatter) destroy;
  }
}

class ExpScatter : GameObject { // 壊れました
  SpriteRenderer sr;
  Transform tf;
  
  Vec2 force;
  RigidBody rb;
  BoxCollider bc;

  real dratio;
  protected ubyte tp;

  this(ubyte[3] colorArr, Vec2 force) {
    tf = register(new Transform(component!Transform.Org.Local, component!Transform.Zoom.Center));
    Vec2 mysize = Vec2(30, 30);
    sr = register(new SpriteRenderer(mysize, colorArr));
    rb = register(new RigidBody(0.2));
    bc = register(new BoxCollider(mysize, false));
    bc.isTrigger = true;
    this.force = force*50;

    dratio = 1;
    sr.setOpac(246);

    layer = -45;
  }

  override void setup() {
    rb.addForce(force);
  }

  override void loop() {
    //dbg(rb.v);
    sr.setOpac(sr.opac - 6);
    if(sr.opac == 0) destroy;
  }
}
