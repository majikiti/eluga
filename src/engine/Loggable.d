module engine.Loggable;

import std.stdio;

class Loggable {
  // sc系、色
  enum scr = "\x1b[31m"; // 赤
  enum scg = "\x1b[32m"; // 緑
  enum scy = "\x1b[34m"; // 黄
  enum scb = "\x1b[34m"; // 青
  enum scm = "\x1b[35m"; // マゼンタ
  enum scc = "\x1b[36m"; // シアン
  enum sco = "\x1b[38;2;255;150;0m"; // 橙
  enum scn = "\x1b[39m"; // 元の色

  // sbc系、背景色
  enum sbcr = "\x1b[48;2;80;0;0m"; // 赤

  // sfb系、フォント種類
  enum sfb = "\x1b[1m"; // bold、太字
  enum sfd = "\x1b[2m"; // dim、薄暗く
  enum sfi = "\x1b[3m"; // italic、斜体
  enum sfu = "\x1b[4m"; // underline、下線
  enum sfr = "\x1b[7m"; // reverse、背景色と文字色を反転
  enum sfn = "\x1b[0m"; // normal、元通り

  // 全てを元に戻す
  enum srst = "\x1b[39;49;0m";

  void dbg(A...)(A a) {
    writeln(sfd, sfi, "[DEBUG]\t", sfn, a, srst);
  }

  void log(A...)(A a) {
    writeln(scg, "[LOG]\t", scn, a, srst);
  }

  void warn(A...)(A a) {
    stderr.writeln(sco, "[WARN]\t", scn, a, srst);
  }

  void err(A...)(A a) {
    stderr.writeln(sfu, sfb, scr, "[ERR]\t", srst, sfb, sbcr, a, srst);
  }
}
