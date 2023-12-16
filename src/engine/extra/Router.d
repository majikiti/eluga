module engine.extra.Router;

alias Route(Ctx) = GameObject function(Ctx ctx);

class Router(GameObject, Ctx): GameObject {
  private GameObject[string] a;

  this(GameObject[string] routes) {
  }
}
