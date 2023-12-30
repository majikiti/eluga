module game.entities.Hero;

import std;
import sdl_mixer;
import engine;
import game;

class Hero: GameObject {
  int life;
  int type;
  real time = 0,jumpSpeed = 3;
  bool isGround = false;

  //// 仮工事
  //real theta = 0;

  Vec2 v = Vec2(2, 2);

  override void setup() {
    register(new Transform(Transform.Org.World)).pos = Vec2(0, 100);
    register(new RigidBody(1)).a = Vec2(0, 0);

    auto hero0 = new ImageAsset("hero0.png");
    auto rend = register(new SpriteRenderer(hero0));
    register(new BoxCollider(rend.size));
    register(new Focus(3)); 
    tags["Player"] = true;
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(im.key('d')||im.key('a')){
      if(im.key('d')) rb.v.x = v.x;
      if(im.key('a')) rb.v.x = -v.x;
    }else{
      rb.v.x = 0;
      rb.v.x = 0;
    }

    //jump
    if(isGround && im.keyOnce(' ')){
      rb.v -= Vec2(0, jumpSpeed);
      isGround = false;
    }

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, Vec2(0, 0), tform.pos + Vec2(0,20)));
      //foreach(int i; 0..628) register(new Missile(Missile.Type.Divergence, Vec2(-cos(i * 0.01), sin(i * 0.01)), tform.pos));
    }
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    if(go.getTag("Ground") && rb.v.y > -1) isGround = true;
  }
}
