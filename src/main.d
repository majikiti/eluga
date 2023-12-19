import engine;
import game;

void main() {
  auto game = new Game;
  auto sys = new System(game);
  sys.run;
}
