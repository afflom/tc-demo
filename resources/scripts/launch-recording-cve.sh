#!/bin/bash

#Launch the recording
asciinema rec -c "./cve-demo.sh" /output/cve-demo-recording-$(date +%s)
