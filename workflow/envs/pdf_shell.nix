{ pkgs }:

with pkgs;

mkShell {
  packages = [
    texlive.combined.scheme-full
    rubber
  ];
}
