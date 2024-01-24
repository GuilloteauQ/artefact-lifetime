{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        myR = pkgs.rWrapper.override {
          packages = with pkgs.rPackages; [ tidyverse geomtextpath ];
        };
      in {
        packages = rec {
          default = ecg;
          notes = pkgs.writeShellApplication {
            name = "notes";
            runtimeInputs = [ pkgs.emacs ];
            text = ''
              emacs -q -l ${./.init.el} notes.org &
            '';
          };
          forms = pkgs.writeShellApplication {
            name = "forms";
            runtimeInputs = [ (pkgs.python3.withPackages (ps: [ ps.pyyaml ])) ];
            text = ''
              python3 ${./forms/eval_forms.py} "$@"
            '';
          };
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
        } // (builtins.listToAttrs (builtins.map (x: {
          name = x;
          value = pkgs.writeShellApplication {
            name = x;
            runtimeInputs = [ myR ];
            text = ''
              Rscript ${./workflow/scripts}/${x}.R "$@"
            '';
          };
        }) [ "summary_conference" ]));
        devShells = {
          default = with pkgs;
            mkShell {
              packages = [ python3 self.packages.${system}.ecg snakemake ];
            };
          rshell = with pkgs;
            mkShell {
              packages = [
                (rWrapper.override {
                  packages = [ rPackages.tidyverse rPackages.geomtextpath ];
                })
              ];
            };
          pdf = with pkgs;
            mkShell {
              packages = [ pandoc texlive.combined.scheme-full rubber vale ];
            };
          rmdshell = with pkgs;
            mkShell {
              packages = [
                pandoc
                texlive.combined.scheme-full
                rubber
                (rstudioWrapper.override {
                  packages = [ rPackages.tidyverse rPackages.rmarkdown ];
                })
                (rWrapper.override {
                  packages = [ rPackages.tidyverse rPackages.rmarkdown ];
                })
              ];
            };
          dev = with pkgs;
            mkShell {
              packages = [ python3 ]
                ++ (with python3Packages; [ pyyaml requests ]);
            };
        };
      });
}
