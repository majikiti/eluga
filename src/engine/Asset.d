module engine.Asset;

import engine;

class Asset: Loggable {
  // asset handling
  package string locateAsset(string path) {
    return "assets/" ~ path;
  }
}
