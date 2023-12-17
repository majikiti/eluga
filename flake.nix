{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = _: prev:
        let pkgs = import nixpkgs { inherit (prev) system; };
        in {
          eluga = pkgs.stdenv.mkDerivation {
            name = "eluga";
            src = ./.;
            buildInputs = with pkgs; [ dub ldc SDL2 SDL2_ttf ];
            buildPhase = ''
              dub build --build=release --compiler=ldc2
            '';
          };
        };
    in
    (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; overlays = [ overlay ]; };
      in {
        packages.default = pkgs.eluga;

        apps.default = {
          type = "app";
          program = toString pkgs.eluga;
        };

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell {
          inputsFrom = pkgs.eluga;
        };
      })) //
    { overlays.default = overlay; };
}
