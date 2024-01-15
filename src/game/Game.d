module game.Game;

import engine;
import game;

alias Router = _Router!int;
alias RouteObject = _RouteObject!int;

enum Routes {
  Home, Title, Editor, GameOver, Abstract,
}

class Game: GameObject {
  Router router;

  override void setup() {
    router = register(new Router(Routes.Home, [
      Routes.Title: new TitleScene(),
      Routes.Home: new HomeScene(),
      Routes.Editor: new EditorScene(),
      Routes.GameOver: new GameOverScene(),
      Routes.Abstract: new AbstractScene(),
    ]));
  }
}
