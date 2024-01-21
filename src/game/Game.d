module game.Game;

import engine;
import game;

alias Router = _Router!int;
alias RouteObject = _RouteObject!int;

enum Routes {
  Title, Game, Editor, GameOver, Abstract,
}

class Game: GameObject {
  Router router;

  override void setup() {
    router = register(new Router(Routes.Game, [
      Routes.Title: new TitleScene(),
      Routes.Game: new GameScene(),
      Routes.Editor: new EditorScene(),
      Routes.GameOver: new GameOverScene(),
      Routes.Abstract: new AbstractScene(),
    ]));
  }

  override void loop() {
    if(im.keyOnce(27)) nuke;
  }
}
