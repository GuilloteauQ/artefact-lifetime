{ pkgs }:

with pkgs;

mkShell {
  packages = [
    typst
    pdf2svg
  ];
}
