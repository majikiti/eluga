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
  Transform tform;
  // ^そのうちStatusに改修する(誰かやってくれるとぼくはうれしいです)
  Vec2 dir = Vec2(1,0);

  //// 仮工事
  //real theta = 0;

  Vec2 v = Vec2(2, 2);

  override void setup() {
    tform = register(new Transform(Transform.Org.World));
    tform.pos = Vec2(0, 100);
    register(new RigidBody(1)).a = Vec2(0, 0);

    auto hero0 = new ImageAsset("hero0.png");
    auto rend = register(new SpriteRenderer(hero0));
    register(new BoxCollider(rend.size));
    register(new Focus(3)); 
    register(new Kalashnikov);
    addTag("Player");
  }

  override void loop() {
    //auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(im.key('d')||im.key('a')){
      if(im.key('d')){
        rb.v.x = v.x;
        dir.x = 1;
      } 
      if(im.key('a')){
        rb.v.x = -v.x;
        dir.x = -1;
      }
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
      register(new Missile(Missile.Type.Normal, dir, tform.pos + Vec2(0,20)));
    }
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    if(go.getTag("Ground") && rb.v.y > -1) isGround = true;
  }
}
