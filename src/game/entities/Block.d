module game.entities.Block;

import engine;
import game;
import sdl_mixer;

class Block: GameObject {
  int life;
  real time = 0;

  Vec2 size = Vec2(1, 1);
  Vec2 v = Vec2(0, 0);

  override void setup() {
    register(new Transform(Transform.Org.World));
    register(new RigidBody(1)).a = Vec2(0, 0);
    register(new BoxCollider);

    auto block = new ImageAsset("assets/block.png");
    register(new SpriteRenderer(block));
  }

  // override void loop() {
  //   auto tform = component!Transform;
  //   auto rb = component!RigidBody;
  //   if(im.key('d')) tform.pos.x += v.x * dur;
  //   if(im.key('a')) tform.pos.x += v.x * dur * -1;

  //   if(tform.pos.y >= 340){
  //     tform.pos.y = 340;
  //     rb.a = Vec2(0, 0);
  //     rb.v = Vec2(0, 0);
  //   }else{
  //     rb.a = Vec2(0, 9.81);
  //   }

  //   //jump
  //   if(tform.pos.y >= 340 && im.keyOnce(' ')){
  //     //auto audio = component!AudioSource;
  //     rb.addForce(Vec2(0, -jumpSpeed));
  //     //rb.v -= Vec2(0, jumpSpeed);
  //     //audio.play();
  //   }

  //   // missile
  //   if(im.keyOnce('\r')){
  //     register(new Missile(Missile.Type.Normal, Vec2(1, 0), tform.pos));
  //   }
  // }

  // override 
}
