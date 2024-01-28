{ pkgs }:

with pkgs;

let
  rpacks = with rPackages; [
    tidyverse
    geomtextpath
    kableExtra
  ];
in
mkShell {
  packages = [
    (rWrapper.override { packages = rpacks; })
  ];
}
