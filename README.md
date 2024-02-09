# Longevity of Artifacts in Top Parallel and Distributed Systems Conferences: a State-of-the-practice Review 

## Reproduce

### Install Nix

The software environment is managed by Nix.

You can install Nix by following the steps described here: [https://nixos.org/download](https://nixos.org/download)

### Activate Nix Flakes

At the moment of this paper submission, the [Nix Flakes feature](https://nixos.wiki/wiki/Flakes) is still experimental.

If this is still the case when you try to reproduce this paper, you will need to activate the feature.

```
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf 
```

### Run the workflow

The workflow of this paper is managed by Snakemake.

#### Run from scratch

No dataset are stored in this repository.
But the forms for each paper are.
Running the workflow will go through the all the forms and convert them into a csv file exploitable by the analysis scripts.

```
nix develop .#default --command snakemake -c 1 rep24/main.pdf
```


#### Run only the analysis

If you want, the dataset is hosted on Zenodo: [https://doi.org/10.5281/zenodo.10640566](https://doi.org/10.5281/zenodo.10640566)

You can download it:

```
mkdir -p data
wget https://zenodo.org/record/10640566/files/all.csv -O data/all.csv
```

The expected MD5 is `md5:cc8e33ac854e4854980f0371380c7229`

You can now run the workflow:

```
nix develop .#default --command snakemake -c 1 rep24/main.pdf
```

### Results

The pdf is available at `rep24/main.pdf`, the figures at `rep24/figs`, and tables at `rep24/tables`.


## Contribute

1. create a folder in `conferences` with the name of the conference (e.g. `eurosys23`)

2. for each paper in the conference:

    - create and open a form: `nix run .#forms -- new -o {NAME}_{TITLE}.yaml` (one name and word for name and title: `wang_cfs.yaml`)

    - answer the questions in the form for this paper

3. recompile `nix develop .#default --command snakemake -c 1`

## ecg

`ecg` is a simple script to check if a Docker image defined in the artifacts of a conference paper still builds and if so, how much did the environment change through time.
Some examples of configurations can be found in the `artefact_configs/` folder.

```
ecg <paper>.yaml
```

The REP'24 submission do not use `ecg`.
