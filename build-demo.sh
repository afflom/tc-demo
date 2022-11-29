#!/bin/bash

run_cmd=$(command -pv podman || command -pv docker)
${run_cmd} build . -t tc-demo
