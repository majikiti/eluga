# Engine

## GameObject

- `GameObject`内の初期化処理はregisterされた瞬間に実行される

- `GameObject`内の更新処理は以下の順番で実行される
  - registerされている`Component`
  - `GameObject`自身
  - registerされている子`GameObject`


### それふま注意点

- コンストラクタでregisterされた`GameObject`は`ctx`と`parent`が未初期化だから気をつけてね
  (一応警告が出るようになってる)
