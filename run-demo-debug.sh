#!/bin/bash

run_cmd=$(command -pv podman || command -pv docker)
# This demo uses containerd and runc, so the --privileged flag is used.
${run_cmd} run -it --rm --volume=$PWD/resources/:/resources/ --entrypoint=bash --privileged tc-demo
