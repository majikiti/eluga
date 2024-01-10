module engine.components.Button;

import engine;

class Button : Component {
  Transform tform;
  Vec2 size = Vec2(0,0);
  bool once = true;
  void delegate() leftEvent,middleEvent,rightEvent;

  this(Vec2 size){
    this.size = size;
    leftEvent = delegate() {return;};
    middleEvent = delegate() {return;};
    rightEvent = delegate() {return;};
  }

  override void loop(){
    tform = go.component!Transform;
    auto sz = Vec2(tform.scale.x*size.x, tform.scale.y*size.y);
    auto im = ctx.im;

    auto begin = tform.pos;
    auto end = begin + sz;
    auto mousePos = im.cusorPos;

    if((im.mouseOnce(0) && once) || (im.mouse(0) && !once)){
      if(inArea(mousePos,begin,end) && leftEvent !is null) leftEvent();
    }
    if((im.mouseOnce(1) && once) || (im.mouse(1) && !once)){
      if(inArea(mousePos,begin,end) && middleEvent !is null) middleEvent();
    }
    if((im.mouseOnce(2) && once) || (im.mouse(2) && !once)){
      if(inArea(mousePos,begin,end) && rightEvent !is null) rightEvent();
    }
  }

  private bool inArea(Vec2 pos, Vec2 begin, Vec2 end){
    if(begin.x > end.x){
      auto buff = begin.x;
      begin.x = end.x;
      end.x = buff;
    }
    if(begin.y > end.y){
      auto buff = begin.y;
      begin.y = end.y;
      end.y = buff;
    }
    auto inWidth = (begin.x <= pos.x && pos.x <= end.x);
    auto inHeight = (begin.y <= pos.y && pos.y <= end.y);

    return inWidth && inHeight;
  }
}
