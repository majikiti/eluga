module game.entities.LifeIndicator;

import std;
import engine;
import game;

class LifeIndicator: GameObject {
  // 各構成要素
  class liObjects: GameObject{
    Transform tform;
    SpriteRenderer liobj;
    Vec2 size;
    Vec2 initpos;
    ubyte[4] vc;

    this(Vec2 size, Vec2 initpos, ubyte[] vc = [255, 255, 255]){
      this.size = size;
      this.initpos = initpos;
      if(vc.length == 3) this.vc = vc ~ cast(ubyte)255;
      else this.vc = vc;
    }

    override void setup() {
      tform = register(new Transform(Transform.Org.Local));
      tform.pos = initpos;
      liobj = register(new SpriteRenderer(size, vc));
    }
  }

  Transform tform;
  liObjects alive;
  Status* st;

  Vec2 border;
  int bthick;
  Vec2 margin;
  
  this(Status* st, Vec2 border = Vec2(100, 30), int bthick = 3, Vec2 margin = Vec2(20,10)){
    this.st = st;
    this.border = border;
    this.bthick = bthick;
    this.margin = margin;
  }

  override void setup() {
    tform = register(new Transform(Transform.Org.Local));
    tform.pos = Vec2(0, -20);
    register(new liObjects(border, tform.pos, [128, 128, 128]));
    register(new liObjects(border - Vec2(bthick*2, bthick*2), tform.pos + Vec2(bthick, bthick), [125, 45, 16]));
    register(new liObjects(border - margin*2, tform.pos + margin, [255, 0, 0]));
    alive = register(new liObjects(border - margin*2, tform.pos + margin, [17, 156, 2]));
  }

  override void loop() {
    alive.component!Transform.scale.x = max(0, cast(real)st.life / cast(real)st.maxlife);
  }
}
