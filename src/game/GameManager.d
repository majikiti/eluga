module game.GameManager;

import utils;
import engine;
import game;

GameManager gm;

struct Status{
  int maxlife;
  int life;
  int damage;
  bool star = false; // 無敵かどうか
  bool isDamaged = false;
  bool willDead = false;
}

struct Persist {
 align(1):
  ubyte ver = 1; // 適当
}

//ゲーム全体のステータスを管理
struct GameManager {
  Status*[GameObject] status;
  GameObject player;
  DataStore!Persist ds;

  auto ref makeStatus(GameObject go, int maxlife = 10, int damage = 1){
    auto s = new Status(maxlife, maxlife, damage);
    return status[go] = s;
  }

  auto ref getStatus(GameObject go) => go ? status[go] : null;

  auto ref playerStatus () => player ? status[player] : null;
}
