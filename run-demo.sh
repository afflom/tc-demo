#!/bin/bash

run_cmd=$(command -pv podman || command -pv docker)
# This demo uses containerd and runc, so the --privileged flag is used.
${run_cmd} run -it --rm --privileged -v mytmp:/tmp -v myvar:/var -v "$PWD"/resources/configs:/resources/configs -v "$PWD"/output:/output tc-demo
${run_cmd} volume rm mytmp
${run_cmd} volume rm myvar