module engine.Asset;

import core.runtime;
import std;
import engine;

class Asset: Loggable {
  // asset handling
  package string locateAsset(string id) {
    static string home = null;
    if(!home) home = Runtime.args[0].dirName;

    auto path = home ~ "/assets/" ~ id;
    if(path.exists) return path;

    auto path2 = home ~ "/../assets/" ~ id;
    if(path2.exists) return path2;

    throw new Error("asset not found at: " ~ path);
  }
}
