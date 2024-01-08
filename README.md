# Eluga

アセットのライセンスについては`assets/LICENSE.md`を参照のこと

## build

```
% docker build -t eluga .
% docker cp $(docker create eluga):/app/Eluga-0.1.0-x86_64.AppImage .
% docker rm $(docker ps -lq)
```
