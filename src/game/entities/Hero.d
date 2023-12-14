module game.entities.Hero;

import engine;
import game;
import sdl_mixer;


class Hero: GameObject {
  int life;
  int type;
  real time = 0,jumpSpeed = 1;

  Vec2 v = Vec2(1, 1);

  this() {
    register(new Transform);
    register(new RigidBody).a = Vec2(0,0);

    auto hero0 = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void setup() {
    
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(im.key('d')) tform.pos.x += v.x * dur;
    if(im.key('a')) tform.pos.x += v.x * dur * -1;

    //jump
    

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, Vec2(1, 0),tform.pos));
    }
  }
}
