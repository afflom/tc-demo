#!/usr/bin/env bash


########################
# include the magic
########################
. ./demo-magic.sh


########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
# TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# text color
# DEMO_CMD_COLOR=$BLACK

# hide the evidence
clear

# Intro

function demoIntro(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=1
  p "Title: Emporous Trusted Content demo"
  p "This demo meets the following objectives:"
  p "1. Build an Emporous Collection from an application"
  p "2. Publish application"
  p "3. Discover applications with Emporous"
  p "3. Pull and run Emporous content"
  p "4. Publish a CVE for previously published content"
  p "5. Discover the CVE \n"
  p "6. Publish an updated Emporous Collection"
  p "7. Discover, update, and run the updated content"
  p "Let's get started!\n"
  clear
}
# Build app v1 Collection

function buildV1(){
  PROMPT_TIMEOUT=3
  p "1. Build an Emporous Collection from an appliation\n"
  p "Author dataset-config.yaml:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/app-v1-dataset-config.yaml"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Add metadata to application:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go build collection -d ../configs/app-v1-dataset-config.yaml ../content/app/v1 next.registry.io/myorg/myapp"
  wait
}

# Publish app v1

function publishApp(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "2. Publish application:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io/myorg/myapp"
  wait
}


# Verify app CVEs prior to running
function checkCVE(){

}


# Pull and run Emporous content

function pullAndRun(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Pull and run application using the Emporous runtime client:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "rcl run --fetch=true next.registry.io/myorg/myapp"
  wait
}

function buildAndPushCVE(){
  # Build CVE Collection
  PROMPT_TIMEOUT=3
  p "1. Build an Emporous Collection from a CVE\n"
  p "Author dataset-config.yaml:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/cve-dataset-config.yaml"
  p "Notice the link from the CVE to our application:\n"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Add metadata to CVE:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go build collection -d ../configs/cve-dataset-config.yaml ../content/cve next.registry.io/myorg/cves"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "2. Publish application:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io/myorg/myapp"
  wait

}


# Build app v2 Collection
function buildV1(){
  PROMPT_TIMEOUT=3
  p "1. Build an Emporous Collection from an appliation\n"
  p "Author dataset-config.yaml:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/app-dataset-config.yaml"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Add metadata to application:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go build collection -d ../configs/app-dataset-config.yaml ./app/v1 next.registry.io/myorg/myapp"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
}


## Discover app update to v2
function discoverApps(){

}


function endDemo(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "\n"
  p "That concludes this demo"
  # show a prompt so as not to reveal our true nature after
  # the demo has concluded
  p ""
}

# "1. Build an Emporous Collection from an application"
buildV1
# "2. Publish application"
publishApp
# "3. Discover applications with Emporous"
discoverApps
# "3. Pull and run Emporous content"
pullAndRun
# "4. Publish a CVE for previously published content"
buildAndPushCVE
# "5. Discover the CVE \n"
discoverCVE
# "6. Publish an updated Emporous Collection"
buildV2
publishApp
# "7. Discover, update, and run the updated content"
discoverApps
pullAndRun
# End
endDemo

