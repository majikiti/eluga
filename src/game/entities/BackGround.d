module game.entities.BackGround;

import engine;
import game;

class BackGround : GameObject {
  Transform tform;
  BackGroundSub[] bgSub;
  string dir;
  Vec2 maxWindowSize;
  Vec2 count;
  Vec2 imgSize;
  this(string dir){
    layer = -100;
    tform = register(new Transform);
    this.dir = dir;
  }

  override void setup(){
    maxWindowSize = windowSize;
    bgSub ~= register(new BackGroundSub(dir));
    imgSize = bgSub[0].size();
    for(count.y = 0; (count.y - 1) * imgSize.y <= windowSize.y; count.y++){
      for(count.x = 0; (count.x - 1) * imgSize.x <= windowSize.x; count.x++){
        if(count.size == 0) continue;
        bgSub ~= register(new BackGroundSub(dir, Vec2(count.x * imgSize.x, count.y * imgSize.y)));
      }
    }
  }

  override void loop(){

    foreach(i, p; bgSub){
      auto tform = p.component!Transform;
      auto camPos = getCamera.pos;
      while(tform.worldPos.x > windowSize.x + camPos.x) tform.pos.x -= windowSize.x + p.size.x;
      while(tform.worldPos.x + p.size.x < camPos.x) tform.pos.x += windowSize.x + p.size.x;
      while(tform.worldPos.y > windowSize.y + camPos.y) tform.pos.y -= windowSize.y + p.size.y;
      while(tform.worldPos.y + p.size.y < camPos.y) tform.pos.y += windowSize.y + p.size.y;
    }
  }
}

class BackGroundSub : GameObject {
  Transform tform;
  ImageAsset ima;
  SpriteRenderer sr;

  this(string dir, Vec2 pos = Vec2(0, 0)){
    layer = -100;
    ima = new ImageAsset(dir);
    tform = register(new Transform(Transform.Org.Local));
    sr = register(new SpriteRenderer(ima));
    tform.pos = pos;
  }

  Vec2 size () => sr.size();
}
