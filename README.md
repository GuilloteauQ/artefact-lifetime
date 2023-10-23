# artefact-lifetime


## Confs to do

- [X] Eurosys 23

- [ ] SC 23

- [ ] OSDI 23: https://www.usenix.org/conference/osdi23/technical-sessions

- [ ] Cluster 23

- [ ] CCGrid 23: https://ieeexplore-ieee-org.sid2nomade-1.grenet.fr/xpl/conhome/10171437/proceeding?isnumber=10171438&sortType=vol-only-seq&pageNumber=3


## Contribute

1. create a folder in `conferences` with the name of the conference (e.g. `eurosys23`)

2. for each paper in the conference:

    - create and open a form: `nix run .#forms -- new -o {NAME}_{TITLE}.yaml` (one name and word for name and title: `wang_cfs.yaml`)

    - answer the questions in the form for this paper

3. recompile `nix develop --command snakemake -c 1`

## ecg

simple script to check if a docker image defined in the artifacts of a conference paper still builds and if so, how much did the environment change through time.

```
ecg <paper>.yaml
```
