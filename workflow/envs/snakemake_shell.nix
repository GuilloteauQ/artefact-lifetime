{ pkgs }:

with pkgs;

mkShell {
  packages = [
    snakemake
  ];
}
