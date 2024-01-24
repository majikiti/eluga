module engine.InputManager;

import std.bitmanip;
import sdl;
import engine;

class InputManager {
  package BitArray state,once;

  this() {
    enum stateSize = ubyte.max;
    state = BitArray(new ubyte[stateSize / 8], stateSize);
    once = BitArray(new ubyte[stateSize / 8], stateSize);
  }

  // keyが押されているかを取得
  bool key(char key) const => state[key];

  // keyが押されたかを1回だけ返す
  bool keyOnce(int key) const {
    return once[key];
  }

  // mouseボタンが押されているかを取得
  // 0:LEFT, 1:MIDDLE, 2:RIGHT
  bool mouse(int btn) const {
    if( btn < 0 || btn > 2) return false;
    return state[btn + 253];
  }

  // mouseボタンが押されたかを1回だけ返す
  // 0:LEFT, 1:MIDDLE, 2:RIGHT
  bool mouseOnce(int btn) const {
    if( btn < 0 || btn > 2) return false;
    return once[btn + 253];
  }

  // マウスカーソルの座標を返す
  Vec2 cusorPos(bool worldPos = false) const {
    int x,y;
    SDL_GetMouseState(&x,&y);
    auto res = Vec2(x,y);
    if(worldPos) res += ctx.camera.pos;
    return res;
  }
}
