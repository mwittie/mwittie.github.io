{
  description = "Literate documentation post tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    mdsh.url = "github:mwittie/mdsh";
  };

  outputs = { self, nixpkgs, mdsh }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.ast-grep
              pkgs.git
              pkgs.go
              pkgs.jq
              pkgs.python3
              mdsh.packages.${system}.default
            ];
            shellHook = ''
              unset GOROOT
              export GOCACHE=/tmp/go-build-cache
              export GOPATH=/tmp/go-path
              export HOME=/tmp
            '';
          };
        }
      );
    };
}