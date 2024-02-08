#!/usr/bin/env bash

import glob
import os
import shutil
import fileinput
import datetime

ymls = glob.glob("**/**/environment.yml", recursive=True)
yamls = glob.glob("**/**/environment.yaml", recursive=True)

yamls.extend(ymls)

top_dir = os.getcwd()
date_tag = datetime.datetime.now().strftime('%Y.%m.%d')

build_images = []
for env in yamls:
    base_dir = os.path.dirname(env)
    if os.path.exists(os.path.join(base_dir, ".skip-jupyter-repo2docker")):
        print("Skipping: ", base_dir)
        continue
    print(f"Processing: {base_dir}")
    dirs = base_dir.split("/")
    version = dirs.pop()
    name = dirs.pop()
    if not os.path.exists(base_dir):
        continue
    os.chdir(base_dir)
    image = f"dabbleofdevops/binder-{name}:{version}"
    cmd = f"jupyter-repo2docker --no-run --image-name {image} ."
    print(f"Running: {name}:{version}")

    try:
        os.system(
            cmd
        )
    except Exception as e:
        print(f"Error: {e}")
        continue

    print(f"Complete: {name}:{version}")
    os.system(f"docker push {image}")
    os.system(f"docker tag {image} {name}:{date_tag}")
    os.system(f"docker push {name}:{date_tag}")
    build_images.append(image)

print("Complete")
print(build_images)
