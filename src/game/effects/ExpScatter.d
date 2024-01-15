module game.effects.ExpScatter;

import std;
import game;
import engine;

class ExpScatter : GameObject {
  SpriteRenderer sr;
  Transform tf;
  
  Vec2 force;
  RigidBody rb;

  real dratio;
  protected ubyte tp;

  this(ubyte[3] colorArr, Vec2 force) {
    tf = register(new Transform(component!Transform.Org.Local, component!Transform.Zoom.Center));
    sr = register(new SpriteRenderer(Vec2(50, 20), colorArr));
    rb = register(new RigidBody(0.2));
    this.force = force*1000;

    dratio = 1;
    tp = 192;

    layer = -45;
  }

  override void setup() {
    rb.addForce(force);
  }

  override void loop() {
    tp-=8;
    sr.opac(tp);
    if(tp == 0) destroy;
  }
}