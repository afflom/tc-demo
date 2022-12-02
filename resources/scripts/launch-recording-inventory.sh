#!/bin/bash

#Launch the recording
asciinema rec -c "./inventory-demo.sh" /output/cve-demo-recording-$(date +%s)
