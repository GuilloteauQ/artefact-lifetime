# Longevity of Artifacts in Leading Parallel and Distributed Systems Conferences: a Review of the State of the practice in 2023 

## Structure

- `conferences/` contains the forms for the surveyed papers per conference

- `forms` contains a Python script to process the forms.

- `workflow/` contains the definitions of the workflow

    - `workflow/envs` contains the Nix shells definitions

    - `workflow/scripts` contains the R scripts for the data analysis

    - `workflow/Snakefile` defintion of the workflow steps

- `rep24/` contains the latex for the paper

- `flake.nix`, `flake.lock` defines the Nix environments

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
# Run the entire workflow
nix develop .#default --command snakemake -c 1
```

(you can choose the number of cores to use for running the workflow with the `-c` flag: `-c 1` means jobs are executed sequentially on a single core)

You can run a subset of the workflow based on what you desire:

```
# Generate the data (data/all.csv)
nix develop .#default --command snakemake -c 1 data

# Generate the data and the figures (rep24/figs/*.pdf)
nix develop .#default --command snakemake -c 1 figs

# Generate the data, the figures, and the paper (rep24/main.pdf)
nix develop .#default --command snakemake -c 1 paper
```


#### Run only the analysis


If you want, the dataset is hosted on Zenodo: [https://doi.org/10.5281/zenodo.10650804](https://doi.org/10.5281/zenodo.10650804)

You can download it:

```
mkdir -p data
wget https://zenodo.org/records/10650804/files/all.csv -O data/all.csv
```

The expected MD5 is `md5:1f437090aa53775dedfc3508206133ed`

You can now run the workflow:

```
nix develop .#default --command snakemake -c 1
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
