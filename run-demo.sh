#!/bin/bash

mkdir mytmp myvar

run_cmd=$(command -pv podman || command -pv docker)
# This demo uses containerd and runc, so the --privileged flag is used.
${run_cmd} run -it  --privileged -v mytmp:/tmp -v myvar:/var tc-demo

rm -rf mytmp myvar