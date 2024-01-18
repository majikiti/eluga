module game.GameManager;

import engine;
import game;

GameManager gm;

struct PlayerStatus{
  int hp = 10;
  bool star = false; // 無敵かどうか
}

//ゲーム全体のステータスを管理
struct GameManager {
  PlayerStatus playerStatus;
  GameObject player;
}
