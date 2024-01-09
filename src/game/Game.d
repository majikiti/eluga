module game.Game;

import engine;
import game;

alias Router = _Router!int;
alias RouteObject = _RouteObject!int;

enum Routes {
  Home, Title,
}

class Game: GameObject {
  Router router;

  override void setup() {
    router = register(new Router(Routes.Title, [
      Routes.Title: new TitleScene(),
      Routes.Home: new HomeScene(),
    ]));
  }
}
