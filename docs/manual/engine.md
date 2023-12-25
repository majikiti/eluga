# Engine

## GameObject

- `GameObject`内の初期化処理は以下の順番で実行される
  - コンストラクタでregisterされた`Component`
  - コンストラクタでregisterされた子`GameObject`
  - `setup()`内でregisterされた`Component`/`GameObject`(随時)

- `GameObject`内の更新処理は以下の順番で実行される
  - registerされている`Component`
  - `GameObject`自身
  - registerされている子`GameObject`

疑似コード:
```py
realSetup():
  for c in components:
    c.setup
  for e in children:
    e.realSetup
  setup

realLoop():
  for c in components:
    c.loop
  loop
  for e in children:
    e.realLoop
```

### それふま注意点

- コンストラクタでregisterされた`GameObject`/`Component`はparentが未初期化だから気をつけてね
  (一応警告が出るようになってる)
