{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
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
        };
        devShells = {
          default = import workflow/envs/snakemake_shell.nix { inherit pkgs; };
          rshell  = import workflow/envs/r_shell.nix { inherit pkgs; };
          pdf     = import workflow/envs/pdf_shell.nix { inherit pkgs; };
        };
      });
}
