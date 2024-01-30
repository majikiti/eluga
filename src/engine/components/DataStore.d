module engine.components.DataStore;

import std;
import engine;

class DataStore(T): Component if(is(T == struct)) {
  union Buf {
    T t;
    ubyte[T.sizeof] a;
  }
  T _old;

  string _path;
  Buf _buf;

  this(string id) {
    _path = _dataDir ~ '/' ~ id;
    if(_path.exists) {
      _buf.a = cast(ubyte[])_path.read;
      return;
    }
    auto dir = _path.dirName;
    if(!dir.exists) dir.mkdir;
  }

  ~this() {
    _sync;
  }

  auto opDispatch(string field)() => mixin(`_buf.t.`~field);
  auto opDispatch(string field, T)(T v) => mixin(`_buf.t.`~field) = v;

  override void setup() {
    NTimer tim;
    if(go.has!NTimer) tim = go.component!NTimer;
    else tim = go.register(new NTimer);
    tim.sched(&_sync, 1000);
  }

  void _sync() {
    std.file.write(_path, _buf.a);
    _old = _buf.t;
  }

  package static string _dataDir() {
    static string datadir = null;
    if(!datadir) {
      datadir = environment.get("XDG_DATA_HOME");
      if(!datadir) {
        auto home = environment.get("HOME");
        if(!home) return "/tmp/eluga";
        datadir = home ~ "/.local/share/eluga";
      }
    }
    return datadir;
  }
}
