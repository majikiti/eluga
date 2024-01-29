module game.entities.Enemy2;

import std;
import engine;
import game;

class Enemy2: Enemy {
  LifeIndicator lifin;
  Status* status;
  override string imgdir() => "flyingenem.png";
  override int point() => 20;

  EnemFoot[2] enmfts;

  Timer jumptmr;
  real limittime = 1;
  auto randomSrc = Random(0);
  ushort bombDrop = 0;

  this(const Vec2 initPos = Vec2(0, 0)){
    super(initPos);
    status = gm.getStatus(this);
  }

  override void setup() {
    super.setup();
    tform.scale = Vec2(0.3, 0.3);
    lifin = register(new LifeIndicator(status));
    rigid = register(new RigidBody(0.1, 1, 10));
    enmfts = [register(new EnemFoot([PI/6, PI/2], 1000)), register(new EnemFoot([-PI/6, -PI/2], 1000))];
    jumptmr = new Timer;
  }
  override void loop() {
    super.loop();

    if(status.willDead) return; // 死の直前にはただ見守ることしかできなかった
    if(jumptmr.cur > limittime) {
      bombDrop++;
      
      if(bombDrop % 10 == 0 && bombDrop != 40) register(new Bomb);

      rigid.a = Vec2(0, 0);
      rigid.addForce(Vec2(uniform(-20, 20, randomSrc), min(max(0, tform.pos.y * 0.5), -10)));
      rigid.v = Vec2(0, 0);
      foreach(enmft; enmfts) enmft.jump;

      randomSrc = Random(cast(uint)jumptmr.cur);
      limittime = uniform(100, 800, randomSrc);
      jumptmr.reset;
    }
  }

  override void collide(GameObject go){
    auto rb = component!RigidBody;
    if(go.getTag("Missile")) {
      register(new Damage);
    }
    if(go.getTag("Ground") && rb.v.y > -1) rb.v.x = 0;
  }
}

// 飾りの足
class EnemFoot: GameObject {
    string imgdir = "EnemFoot.png";
    SpriteRenderer sr;

    Transform tf;
    real radius;
    real dt; // 差分
    real[2] angrange; // 0:内側, 1:外側
    Vec2 rvec;

    private bool jumping;
    private real angle;
    private real angwidth;
    private real tanim;

    this(real[2] angrange, real radius, real dt = 0.03) {
      this.angrange = angrange;
      this.radius = radius;
      this.dt = dt;

      sr = register(new SpriteRenderer(new ImageAsset(imgdir)));

      rvec = Vec2(0, radius); // 下を0度とする
      angle = angrange[0]; // 最内を取る
      rvec.rot(angle); // 最下ベクトルへ
      angwidth = angrange[1] - angrange[0]; 

      tf = register(new Transform(tf.Org.Local));
      tf.scale = Vec2(0.2, 0.2);
    }

    override void loop() {
      real upside(real t) => angrange[0] + angwidth * (1 - exp(-1 * t));
      real downside(real t) => angrange[0] + angwidth * (exp(-1 * t * 0.001));

      if(jumping){
        angle = upside(tanim);
        if(angrange[1] - angle < 0.0001) {
          tanim = 0;
          jumping = false;
        }
      } else {
        angle = downside(tanim);
      }
      rvec.rot(angle);
      tanim += dt;
    }

    void jump() {
      tanim = 0;
      jumping = true;
    }
  }
