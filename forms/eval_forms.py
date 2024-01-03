import yaml
import os
import argparse
import logging
import csv
import subprocess
from string import Template
from datetime import datetime


logging.basicConfig(level=logging.INFO)

template = Template(
"""doi: ""
pdf: ""
date_eval: "$date"
# ----- BADGES ----
badges: 0 # how many badges?
badge_avaible: false
badge_evaluated_functional: false
badge_reproduced: false

# ----- PAPER ------
artefact_section: false # is there a "artefact" section in the paper?
repo_url: false # is the url of the repo given in the paper?
dead_url: false # is the url still working?
minimal_working_example: false # is there a minimal example?
estimated_human_compute_time: false # is the time estimation given?
experimental_setup: "homemade" # some random machines
# experimental_setup: "testbed" # chameleon/grid5000
# experimental_setup: "proprietary" # AWS/Azure/...


# ----- REPO -----
pinned_version: false # is the version of the code used pinned? commit/zenodo/swh?
nb_commits_repo: 0 # how many commits in the repo?
how_shared: "git" # how the repo/code was shared?
# how_shared: "git+zenodo"
# how_shared: "zenodo"
# how_shared: "swh"
# how_shared: "cloud" # google docs or similar
# how_shared: "indirect" # like to the website of the project but not the repo

# ----- SW ENV ------
techno: "none"
# techno: "docker"
# techno: "singularity"
# techno: "vagrant"
# techno: "kameleon"
bin_cache: false # is the binary of the image stored somewhere?
bin_cache_long_term: false # can the stored image be available "forever"? (e.g. zenodo)
recipe_in_repo: false
sw_env:
  # - list
  # - list_loose_version # like >=
  # - list_strict_version # like ==
  # - apt_commands # or other package managers
  # - git_curl_commands_unsafe  # not checking commit/tag
  # - git_curl_commands_safe # checking commit/tag
  # - git_curl_commands_safest # also checking result
  # - untagged_or_short_life_base_image # or latest/master or known to have limited lifetime
  # - conda
  # - pip
  # - spack
  # - nix
  # - guix
  # - container
  # - vm
  # - system_image
""")

def read_yaml(filename):
    with open(filename, "r") as yaml_file:
        data = yaml.safe_load(yaml_file)
        assert 'pdf' in data, "Missing `pdf` field"
        data['pdf_available'] = (len(data['pdf']) > 0)
        return data

def main():
    parser = argparse.ArgumentParser(description="Evaluate the forms")

    subparsers = parser.add_subparsers(help='sub-command help')

    parser_check = subparsers.add_parser("check", help='check forms')
    parser_check.add_argument("form", type=str, nargs='+', help='forms')
    parser_check.add_argument("-o", "--output", help="output file", required=True)
    parser_check.add_argument("-c", "--conference", help="name of the conference", required=True)

    parser_create = subparsers.add_parser("new", help='create new form')
    parser_create.add_argument("-o", "--output", help="output file", required=True)

    args = parser.parse_args()

    if "form" not in args:
        form = template.substitute(date=datetime.today().strftime('%Y-%m-%d'))
        with open(args.output, "w") as output_file:
            output_file.write(form)
        EDITOR = os.environ.get('EDITOR', 'nvim')
        subprocess.run(f"{EDITOR} {args.output}", shell=True)
    else:
        with open(args.output, 'w', newline='') as csvfile:
            fieldnames = [\
                'doi',\
                'conference',\
                'date_eval',\
                'pdf_available',\
                'badges',\
                'badge_avaible',\
                'badge_evaluated_functional',\
                'badge_reproduced',\
                'artefact_section',\
                'repo_url',\
                'dead_url',\
                # 'minimal_working_example',\
                # 'estimated_human_compute_time',\
                'experimental_setup',\
                'pinned_version',\
                'nb_commits_repo',\
                'how_shared',\
                'techno',\
                'bin_cache',\
                'bin_cache_long_term',\
                'recipe_in_repo',\
                'sw_env_method'
            ]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames, extrasaction='ignore')
            writer.writeheader()
            for f in args.form:
                logging.info(f"Reading file {f}")
                data = read_yaml(f)
                if data['doi'] is None or len(data['doi']) == 0:
                    data['doi'] = f
                data['conference'] = args.conference
                if data['sw_env'] is None or len(data['sw_env']) == 0:
                    data['sw_env'] = ["none"]
                for sw_env_method in data['sw_env']:
                    data['sw_env_method'] = sw_env_method
                    writer.writerow(data)
    return 0

if __name__ == "__main__":
    main()
