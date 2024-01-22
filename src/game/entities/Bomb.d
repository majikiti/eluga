module game.entities.Bomb;

import std;
import game;
import engine;

class Bomb : GameObject {
  SpriteRenderer rend;
  Transform tform;
  RigidBody rigid;
  string imgdir() => "bomb.png";
  AudioSource se;

  bool isExplosion = false;

  this() {
    auto bokan = new AudioAsset("dogaan.mp3");
    se = register(new AudioSource(bokan));
    se.volume(20);
    addTag("Bomb");
    // 僕はHikakin 死亡
    tform = register(new Transform(tform.Org.Spawn));
    tform.scale = Vec2(0.2, 0.2);
  }

  override void setup() {
    auto bomb = new ImageAsset(imgdir);
    rend = register(new SpriteRenderer(bomb));

    auto colid = register(new BoxCollider(rend.size));
  }

  override void loop() {
    if(isExplosion) rend.setOpac(cast(int)rend.opac / 2);
  }

  override void collide(GameObject go) {
    if(go.getTag("Missile")) explosion;
  }

  void explosion() {
    if(!isExplosion) {
      se.play(1);
      register(new Explosion);
      isExplosion = true;
    }
    if(has!Explosion) return;
    destroy;
  } // 死と向き合う関数
}