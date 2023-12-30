module stageCreator.ui.Tile;

import engine;

class Tile : GameObject {
  Vec2 pixelSize = Vec2(0,0);
  Transform tform;
  SpriteRenderer rend;
  Button btn;

  this(Vec2 pos, ImageAsset img){
    tform = register(new Transform(Transform.Org.World));
    tform.pos = pos;
    tform.scale = Vec2(0.1,0.1);
    rend = register(new SpriteRenderer(img));
    rend.active = false;

    void delegate() event0 = {rend.active = true;};
    void delegate() event2 = {rend.active = false;};

    btn = register(new Button(rend.size));
    btn.leftEvent = event0;
    btn.rightEvent = event2;
    btn.once = false;
  }
}
