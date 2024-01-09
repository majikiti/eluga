module game.stages.editor.EditorScene;

import engine;
import game;

class EditorScene: RouteObject {
  override void setup() {
    register(new Cusor);
    register(new TileMap);
  }
}
