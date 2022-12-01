#!/bin/bash

run_cmd=$(command -pv podman || command -pv docker)
DOCKER_BUILDKIT=1 ${run_cmd} build . -f "$1" -t "$2"
