module game.Don;

import std;
import engine;

struct Don(string file) {
  enum don = import(file).parseDon;
}

auto parseDon(string src) {
  string[] tags;
  char[] chrs;
  auto lines = src.splitLines;
  size_t cur;
  foreach(i, line; lines) {
    if(!line.length) {
      cur = i;
      break;
    }
    chrs ~= line[0];
    tags ~= line[1..$].strip;
  }
  auto orig = tags.countUntil("orig");
  auto mat = lines[cur+1..$]
    .map!(line => line
      .map!(c => chrs.countUntil(c))
      .array)
    .array;
  Vec2fixed delta;
  foreach(y, row; mat) foreach(x, c; row) if(c == orig) {
    delta.x = x, delta.y = y;
    break;
  }
  mat[delta.y][delta.x] = -1;
  return tuple!("tags", "mat", "delta")(tags, mat, delta);
}
