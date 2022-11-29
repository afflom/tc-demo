#!/bin/bash

#Launch the recording
asciinema rec -c "./trusted-content-demo.sh" /output/cve-demo-recording-$(date +%s)
