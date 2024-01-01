module game.entities.Hero;

import engine;
import game;
import sdl_mixer;
import std;

class Hero: GameObject {
  int life;
  int type;
  real time = 0,jumpSpeed = 6;

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
    if(tform.pos.y >= 340 && im.keyOnce(' ')){
      rb.v -= Vec2(0, jumpSpeed);
    }

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, Vec2(100, 0), tform.pos));
    }
  }
}
