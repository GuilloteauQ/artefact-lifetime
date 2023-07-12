{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = rec {
        default = ecg;
        ecg = pkgs.python3Packages.buildPythonPackage {
          name = "ecg";
          version = "0.0.1";
          src = ./ecg;
          propagatedBuildInputs = with (pkgs.python3Packages); [
            pyyaml
            requests
          ];
          doCheck = false;
        };
      };
      devShells.${system} = {
        default = with pkgs;
          mkShell { packages = [ python3 self.packages.${system}.ecg snakemake ]; };
        dev = with pkgs; mkShell { packages = [python3] ++ 
          (with python3Packages; [ pyyaml requests ]); };
      };
    };
}
