{ pkgs }:

with pkgs;

let
  rpacks = with rPackages; [
    tidyverse
    geomtextpath
  ];
in
mkShell {
  packages = [
    (rWrapper.override { packages = rpacks; })
  ];
}
