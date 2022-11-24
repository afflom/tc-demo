#!/bin/bash

#Launch the recording
asciinema rec -c "./trusted-content-demo.sh" cve-demo-recording-$(date +%s)
