#!/bin/bash

run_cmd=$(command -pv podman || command -pv docker)
# This demo uses containerd and runc, so the --privileged flag is used.
${run_cmd} run -it --rm --volume=/tmp:/tmp --volume=$PWD/resources/:/resources/ --volume=/var:/var --volume=/run/containerd/containerd.sock:/run/containerd/containerd.sock --privileged tc-demo
