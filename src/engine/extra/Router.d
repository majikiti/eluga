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
      currentGO = register(routes[current]);
      currentGO.route;
    }
  }

  void go(T route) {
    ctx.camera.center = Vec2(0, 0);
    current = route;
    change = true;
  }
}

class _RouteObject(T): GameObject {
  protected _Router!T router;

  void route() {}
}
