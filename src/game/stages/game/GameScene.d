module game.stages.game.GameScene;

import engine;
import game;

class GameScene: RouteObject {
  override void setup() {
    auto stage = "1-1";
    register([
      "1-1": () => new Patio,
    ][stage]());
  }
}
