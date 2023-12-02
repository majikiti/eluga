import engine;
import game;

void main() {
  import std;
  writeln(1); stdout.flush;
  auto game = new Game;
  writeln(2); stdout.flush;
  auto sys = new System(game);
  writeln(3); stdout.flush;
  sys.run;
}
