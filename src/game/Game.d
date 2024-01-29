module game.Game;

import engine;
import game;

alias Router = _Router!int;
alias RouteObject = _RouteObject!int;

enum Routes {
  Title, Game, Editor, GameOver, Abstract, Test, GameClear,
}

class Game: GameObject {
  Router router;
  GameObject debugTools;

  this() {
    // Time Watchdog
    gm.tmr = register(new NTimer);
  }

  override void setup() {
    gm.ds = register(new DataStore!Persist("main.dat"));
    router = register(new Router(Routes.Abstract, [
      Routes.Title: new TitleScene(),
      Routes.Game: new GameScene(),
      Routes.Editor: new EditorScene(),
      Routes.GameOver: new GameOverScene(),
      Routes.Abstract: new AbstractScene(),
      Routes.Test: new TestScene(),
      Routes.GameClear: new GameClearScene(),
    ]));
    debugTools = register(new DebugTools(router));
  }

  override void loop() {
    if(im.keyOnce(27)) nuke;
  }
}
