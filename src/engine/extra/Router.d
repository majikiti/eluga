module engine.extra.Router;

import engine;

class _Router(T): GameObject {
  private _RouteObject!T[T] routes;
  private T current;
  private GameObject currentGO = null;
  private bool change = false;

  this(T init, _RouteObject!T[T] routes) {
    this.current = init;
    this.routes = routes;
    foreach(i; routes.keys) routes[i].router = this;
  }

  override void setup() {
    this.currentGO = register(routes[current]);
  }

  override void loop() {
    if(change) {
      change = false;
      currentGO.destroy;
      currentGO = register(routes[current]);
    }
  }

  void go(T route) {
    current = route;
    change = true;
  }
}

class _RouteObject(T): GameObject {
  protected _Router!T router;
}
