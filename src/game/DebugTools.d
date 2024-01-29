module game.DebugTools;

import engine;
import game;
import std;

DebugManager dm;

struct DebugManager {

  bool debugMode = true;

  // page 1
  bool speedupX = false; // 横方向の移動速度が2 -> 10
  bool moonJump = false; // W,Sキーで上下に自由に移動できるようになる
  bool rapidFire = false;
  bool noGravity = true;
  bool teleport = false;
  // maxLife;
  // Life1;
  // Death;

  // page 2
  bool createEntity1 = false;
  bool createEntity2 = false;
  bool createEntity3 = false;
  bool createEntity4 = false;
  bool createEntity5 = false;
  bool createBomb = false;
  // teleportOrigin
}

class DebugTools : GameObject {
  Text lt;
  Router router;

  int maxPage = 3;
  int page = 1;

  this(Router router) {
    layer = 254;
    this.router = router;
  }

  override void setup() {
    auto tform = register(new Transform(Transform.Org.Real));

    auto font = new TextAsset("PixelMplus-20130602/PixelMplus12-Regular.ttf", 16);
    lt = register(new Text(font));
    lt.setColor(255, 64, 64);
    lt.active = false;

    textUpdate;
    
  }

  debug:
  override void debugLoop() {
    component!Transform.pos = Vec2(windowSize.x - 200, 8);
    if(im.keyOnce('p')){
      dm.debugMode = !dm.debugMode;
    }
    lt.active = dm.debugMode;
    if(!dm.debugMode) return;

    if(im.key('k')){
      if(page == 1) page1Func;
      if(page == 2) page2Func;
      if(page == 3) page3Func;

      if(im.keyOnce('9')){
        if(page > 1){
          page--;
          textUpdate;
        }
      }
      if(im.keyOnce('0')){
        if(page < maxPage){
          page++;
          textUpdate;
        }
      }
    }


    if(dm.createEntity1 || dm.createEntity2 || dm.createEntity3 || dm.createEntity4 || dm.createEntity5) createEntity;
    if(dm.teleport) teleport;
  }

  void createEntity(){
    if(im.mouseOnce(2)){
      if(dm.createEntity1)register(new Enemy1(im.cusorPos(true)));
      if(dm.createEntity2)register(new Enemy2(im.cusorPos(true)));
      if(dm.createEntity3)register(new Enemy3(im.cusorPos(true), gm.hero.component!Transform));
      if(dm.createEntity4)register(new Enemy4(im.cusorPos(true), gm.hero.component!Transform));
      if(dm.createEntity5)register(new Enemy5(im.cusorPos(true), gm.hero.component!Transform));
      if(dm.createBomb   )register(new Bomb);
    }
  }

  void teleport(){
    if(im.mouseOnce(2)) gm.hero.component!Transform.pos = im.cusorPos(true);
  }

  void page1Func(){
    if(im.keyOnce('1')){
      dm.speedupX = !dm.speedupX;
      textUpdate;
    }
    if(im.keyOnce('2')){
      dm.moonJump = !dm.moonJump;
      textUpdate;
    }
    if(im.keyOnce('3')){
      dm.rapidFire = !dm.rapidFire;
      textUpdate;
    }
    if(im.keyOnce('4')){
      dm.noGravity = !dm.noGravity;
      textUpdate;
    }
    if(im.keyOnce('5')){
      dm.teleport = !dm.teleport;
      textUpdate;
    }
    if(im.keyOnce('6')){
      gm.heroStatus.life = gm.heroStatus.maxlife;
    }
    if(im.keyOnce('7')){
      gm.heroStatus.life = 1;
    }
    if(im.keyOnce('8')){
      gm.heroStatus.life = 0;
    }
  }

  void page2Func(){
    if(im.keyOnce('1')){
      dm.createEntity1 = !dm.createEntity1;
      textUpdate;
    }
    if(im.keyOnce('2')){
      dm.createEntity2 = !dm.createEntity2;
      textUpdate;
    }
    if(im.keyOnce('3')){
      dm.createEntity3 = !dm.createEntity3;
      textUpdate;
    }
    if(im.keyOnce('4')){
      dm.createEntity4 = !dm.createEntity4;
      textUpdate;
    }
    if(im.keyOnce('5')){
      dm.createEntity5 = !dm.createEntity5;
      textUpdate;
    }
    if(im.keyOnce('6')){
      dm.createBomb = !dm.createBomb;
      textUpdate;
    }
    if(im.keyOnce('7')){

    }
    if(im.keyOnce('8')){
      gm.hero.component!Transform.pos = Vec2(0, 0);
      gm.hero.component!RigidBody.v = Vec2(0, 0);
      gm.hero.component!RigidBody.a = Vec2(0, 0);
    }
  }

  void page3Func(){
    if(im.keyOnce('1')){
      router.go(Routes.Title);
    }
    if(im.keyOnce('2')){
      router.go(Routes.Game);
    }
    if(im.keyOnce('3')){
      router.go(Routes.Editor);
    }
    if(im.keyOnce('4')){
      router.go(Routes.GameOver);
    }
    if(im.keyOnce('5')){
      router.go(Routes.Abstract);
    }
    if(im.keyOnce('6')){
      router.go(Routes.Test);
    }
    if(im.keyOnce('7')){

    }
    if(im.keyOnce('8')){

    }
  }

  void textUpdate(){
    string lstr;

    lstr ~= [
      "GAME DEBUG TOOLS\n",
      "page " ~ page.to!string ~ "/" ~ maxPage.to!string,
      "[k]key + \n",
    ].join('\n');

    if(page == 1){
      lstr ~= [
        "[1]:speedupX         " ~ "[" ~ (dm.speedupX ? "o" : "-") ~ "]",
        "[2]:moonJump         " ~ "[" ~ (dm.moonJump ? "o" : "-") ~ "]",
        "[3]:rapidFire        " ~ "[" ~ (dm.rapidFire ? "o" : "-") ~ "]",
        "[4]:noGravity        " ~ "[" ~ (dm.noGravity ? "o" : "-") ~ "]",
        "[5]:teleport         " ~ "[" ~ (dm.teleport ? "o" : "-") ~ "]",
        "[6]:maxLife          ",
        "[7]:Life1            ",
        "[8]:death            ",
      ].join('\n');
    }
    else if(page == 2){
      lstr ~= [
        "[1]:createEntity1    " ~ "[" ~ (dm.createEntity1 ? "o" : "-") ~ "]",
        "[2]:createEntity2    " ~ "[" ~ (dm.createEntity2 ? "o" : "-") ~ "]",
        "[3]:createEntity3    " ~ "[" ~ (dm.createEntity3 ? "o" : "-") ~ "]",
        "[4]:createEntity4    " ~ "[" ~ (dm.createEntity4 ? "o" : "-") ~ "]",
        "[5]:createEntity5    " ~ "[" ~ (dm.createEntity5 ? "o" : "-") ~ "]",
        "[6]:createBomb       " ~ "[" ~ (dm.createBomb    ? "o" : "-") ~ "]",
        "[7]:                 " ,
        "[8]:teleportOrigin   " ,
      ].join('\n');
    }
    else if(page == 3){
      lstr ~= [
        "[1]:Title            " ,
        "[2]:Game             " ,
        "[3]:Editor           " ,
        "[4]:GameOver         " ,
        "[5]:Abstract         " ,
        "[6]:Test             " ,
        "[7]:                 " ,
        "[8]:                 " ,
      ].join('\n');
    }

    lstr ~= [
      "",
      "[9]:prePage            ",
      "[0]:nextPage           ",
    ].join('\n');

    lt.text = lstr;
  }
}
