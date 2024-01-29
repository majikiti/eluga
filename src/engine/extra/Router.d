module engine.extra.Router;

import engine;

class _Router(T): GameObject {
  alias RouteObject = _RouteObject!T;

  private RouteObject[T] routes;
  private T current;
  private RouteObject currentGO = null;
  private bool change = false;

  this(T init, _RouteObject!T[T] routes) {
    this.current = init;
    foreach(i; routes.keys) registerRoute(i, routes[i]);
  }

  auto registerRoute(T id, _RouteObject!T route) {
    route.router = this;
    return routes[id] = route;
  }

  override void setup() {
    this.currentGO = register(routes[current]);
  }

  override void loop() {
    if(change) {
      change = false;
      currentGO.bye;
      ctx.camera.fgo = null;
      ctx.camera.pos = Vec2(0, 0);
      currentGO = routes[current] = register(routes[current].reincarnate); // unko
      currentGO.route;
    }
  }

  void go(T route) {
    current = route;
    change = true;
  }
}

class _RouteObject(T): GameObject {
  alias Router = _Router!T;
  alias RouteObject = _RouteObject!T;

  protected Router router;

  RouteObject reincarnate() {
    err("default reincarnate() called: ", this);
    return this;
  }

  // to use: mixin(enableReincarnate);
  enum enableReincarnate = q{
    override RouteObject reincarnate() {
      auto self = new typeof(this);
      self.router = router;
      return self;
    }
  };

  void route() {}
}
