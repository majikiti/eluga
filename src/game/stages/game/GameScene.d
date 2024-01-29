module game.stages.game.GameScene;

import engine;
import game;

class GameScene: RouteObject {
  this() {
    gm.tmr.reset;
    gm.tmr.sched(&timeOver, gm.T_LIMIT);
    gm.tmr.sched(&timeWarn, gm.T_LIMIT - 100_000);
  }

  override void setup() {
    auto stage = "1-1";
    register([
      "1-1": () => new Patio(router),
    ][stage]());
  }

  void timeOver() {
    router.go(Routes.GameOver);
    gm.tmr.unsched(&timeOver);
  }

  void timeWarn() {
    dbg("密輸を許さないワン！");
    auto warn = new AudioAsset("warning.mp3");
    auto se = register(new AudioSource(warn));
    se.volume(20);
    se.play(0);
    gm.tmr.unsched(&timeWarn);
  }

  mixin(enableReincarnate);
}
