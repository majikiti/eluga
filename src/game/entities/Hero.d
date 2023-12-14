module game.entities.Hero;

import engine;
import game;
import sdl_mixer;


class Hero: GameObject {
  int life;
  int type;
  real time = 0,jumpSpeed = 3;

  Vec2 v = Vec2(1, 1);

  this() {
    register(new Transform);
    register(new RigidBody).a = Vec2(0,0);

    auto hero0 = new ImageAsset("assets/hero0.png");
    register(new SpriteRenderer(hero0));
  }

  override void setup() {
    auto jumpSE = new AudioAsset("assets/se_jump1.mp3");
    auto audio = register(new AudioSource(jumpSE));
    audio.volume(15);
  }

  override void loop() {
    auto tform = component!Transform;
    auto rb = component!RigidBody;
    if(im.key('d')) tform.pos.x += v.x * dur;
    if(im.key('a')) tform.pos.x += v.x * dur * -1;

    if(tform.pos.y >= 340){
      tform.pos.y = 340;
      rb.a = Vec2(0, 0);
      rb.v = Vec2(0, 0);
    }else{
      rb.a = Vec2(0, 9.81);
    }

    //jump
    if(tform.pos.y >= 340 && im.keyOnce(' ')){
      auto audio = component!AudioSource;
      rb.v -= Vec2(0, jumpSpeed);
      audio.play();
    }

    // missile
    if(im.keyOnce('\r')){
      register(new Missile(Missile.Type.Normal, Vec2(1, 0),tform.pos));
    }
  }
}
