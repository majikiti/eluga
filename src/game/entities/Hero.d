module game.entities.Hero;

import engine;
import game;
import sdl_mixer;
import std;

class Hero: GameObject {
  int life;
  int type;
  real time = 0,jumpSpeed = 3;

  // 仮工事
  real theta = 0;

  Vec2 v = Vec2(1, 1);
  
  override void setup() {
    register(new Transform(Transform.Org.World));
    register(new RigidBody(1)).a = Vec2(0, 0);

    auto hero0 = new ImageAsset("hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(im.key('d')) tform.pos.x += v.x * dur;
    if(im.key('a')) tform.pos.x += v.x * dur * -1;

    // 仮工事2.0
    auto wave = (2 + sin(theta));
    theta += 0.04;
    tform.scale = Vec2(wave, wave);

    if(tform.pos.y >= 340){
      tform.pos.y = 340;
      rb.a = Vec2(0, 0);
      rb.v = Vec2(0, 0);
    }else{
      rb.a = Vec2(0, 9.81);
    }

    //jump
    if(tform.pos.y >= 340 && im.keyOnce(' ')){
      //auto audio = component!AudioSource;
      // rb.addForce(Vec2(0, -jumpSpeed));
      rb.v -= Vec2(0, jumpSpeed);
      //audio.play();
    }

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, Vec2(1, 0), tform.pos));
    }
  }
}
