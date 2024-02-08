#!/usr/bin/env bash

import glob
import os
import shutil
import fileinput

ymls = glob.glob("**/**/*yml", recursive=True)
yamls = glob.glob("**/**/*yaml", recursive=True)

yamls.extend(ymls)
# print(yamls)
replace_this = """environment_file = \"%(namelower)s-%(version)s.yml\""""
replace_with = """environment_file = \"environment.yml\""""

for yaml in yamls:
    orig_yaml = yaml
    if "environment.yaml" in yaml:
        continue
    yaml = yaml.replace(".yaml", "")
    yaml = yaml.replace(".yml", "")
    base_dir = os.path.dirname(yaml)
    t = os.path.basename(yaml).split("-")
    name = t.pop(0)
    skip = os.path.join(base_dir, ".skip-jupyter-repo2docker")
    if len(name):
        version = ""
        if len(t):
            version = "-".join(t)
        print(f"Name: {name} Version: {version}")
    else:
        print(f"No name found: {yaml}")

    if not name or not version:
        continue

    new_dir = os.path.join(base_dir, name, version)
    os.makedirs(new_dir, exist_ok=True)
    shutil.move(orig_yaml, os.path.join(new_dir, "environment.yml"))
    shutil.move(os.path.join(base_dir, f"{name}-{version}.eb"), os.path.join(new_dir, f"{name}-{version}.eb"))
    with fileinput.FileInput(os.path.join(new_dir, f"{name}-{version}.eb"), inplace=True, backup=".bak") as file:
        for line in file:
            print(line.replace(replace_this, replace_with), end='')
