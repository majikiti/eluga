module game.stages.theabstract.AbstractScene;

import std;
import game;
import engine;

class AbstractScene: RouteObject {
  TextBox tl0, ttl, tl1, tl2, tl3, tl4;
  ImageBox ib0, ib1, ib2;
  Transform tf;
  AudioAsset BGM;
  AudioSource audio;
  Focus fc;
  Timer tmr;
  real theta;

  //3153年、南北アメリカ大陸は魔法少女の国・ホンジュラスによって統一された。
  //しかし、3289年、遠い未来からやってきた軍備ムキムキのアルメニア軍によってもはやホンジュラスは滅亡の危機に瀕している！
  //君はホンジュラスの皇位継承権付き魔法少女だ！君が南北アメリカをその手に持つ"クルド☆ジハード"でアルメニアの魔の手から解放し、再びホンジュラスを統一大陸アメリカの象徴とするのだ！
  //ホンジュラスに栄光あれ！
  
  this() {
    tf = register(new Transform);

    tl0 = register(new TextBox("Welcome to"));
    tl0.component!Text.setColor(225, 225, 255);
    tl0.tform.pos = Vec2(20, 200);

    ttl = register(new TextBox("ホンジュラス"));
    ttl.component!Text.setColor(225, 225, 255);
    ttl.tform.scale = Vec2(1.5, 1.5);
    ttl.tform.pos = Vec2(20, 300);

    tl1 = register(new TextBox("3153年、南北アメリカ大陸は\n魔法少女の国・ホンジュラス\nによって統一された。"));
    tl1.component!Text.setColor(225, 225, 255);
    tl1.tform.pos = Vec2(20, 620);

    ib0 = register(new ImageBox("abstract/doc1.png"));
    ib0.tform.pos = Vec2(30, 800);
    ib0.tform.scale = Vec2(0.45, 0.45);

    tl2 = register(new TextBox("しかし、3289年、遠い未来から\nやってきたアルメニア軍によって\nもはやホンジュラスは滅亡の危機\nに瀕している！"));
    tl2.component!Text.setColor(225, 225, 255);
    tl2.tform.pos = Vec2(20, 1220);

    ib1 = register(new ImageBox("abstract/doc2.png"));
    ib1.tform.pos = Vec2(30, 1460);
    ib1.tform.scale = Vec2(0.45, 0.45);

    tl3 = register(new TextBox("君はホンジュラスの皇位継承権を\n持った魔法少女だ！\n君が南北アメリカをその手に\n持つ「クルド☆ジハード」で\nアルメニアの魔の手から解放し、\n再びホンジュラスを\n統一大陸アメリカの\n象徴とするのだ！"));
    tl3.component!Text.setColor(225, 225, 255);
    tl3.tform.pos = Vec2(20, 1880);

    ib2 = register(new ImageBox("abstract/doc3.png"));
    ib2.tform.pos = Vec2(30, 2260);
    ib2.tform.scale = Vec2(0.45, 0.45);

    tl4 = register(new TextBox("ホンジュラスに栄光あれ！"));
    tl4.component!Text.setColor(225, 225, 255);
    tl4.tform.scale = Vec2(1.3, 1.3);
    tl4.tform.pos = Vec2(20, 2820);

    tmr = new Timer;
  }
 
  override void setup() {
    BGM = new AudioAsset("The_distant_TERRA.mp3");
    audio = register(new AudioSource(BGM));
    audio.play(-1);
    audio.volume(30);
  }

  override void loop() {
    if(tmr.cur>=50) {
      tf.pos -= Vec2(0, 2);
      tmr.reset;
    }
  }
}