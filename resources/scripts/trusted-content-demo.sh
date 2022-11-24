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
#clear

# Intro

function demoIntro(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=1
  p "Title: Emporous Trusted Content demo"
  p "This demo meets the following objectives:"
  p "1. Build an Emporous Collection from an application"
  p "2. Publish application"
  p "3. Discover applications with Emporous"
  p "4. Pull and run Emporous content"
  p "5. Publish a CVE for previously published content"
  p "6. Discover the CVE"
  p "7. Publish an updated Emporous Collection"
  p "8. Discover, update, and run the updated content"
  p "Let's get started!\n"
  clear
}
# Build app v1 Collection

function buildV1(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
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

# Publish app

function publishApp(){
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io/myorg/myapp"
  wait
}


# Verify app CVEs prior to running
function checkCVE(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Poll the Emporous endpoint for vulnerability updates:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go pull --attributes=../configs/cve-attribute-query.yaml"
  wait
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
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
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
  p "Publish CVE:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io/myorg/cves"
  wait

}


# Build app v2 Collection
function buildV2(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Author dataset-config.yaml:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/app-v2-dataset-config.yaml"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Add metadata to the updated application:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go build collection -d ../configs/app-v2-dataset-config.yaml ../content/app/v2 next.registry.io/myorg/myapp"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
}


## Discover app update to v2
function discoverApps(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Poll the Emporous endpoint for application updates:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go pull --attributes=../configs/app-attribute-query.yaml /dev/null --no-verify=true"
  wait
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






export PATH=$PATH:$PWD/distribution/bin:$PWD/client/bin:$PWD/runc-attributes-wrapper/bin

# Start the registry 
registry serve cmd/registry/config-dev.yml &>/dev/null

# Intro
demoIntro
# "1. Build an Emporous Collection from an application"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "1. Build an Emporous Collection from an updated appliation\n"
buildV1
# "2. Publish application"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "2. Publish application:\n"
publishApp
# "3. Discover applications with Emporous"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "3. Discover applications with Emporous:\n"
discoverApps
# "4. Pull and run Emporous content"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "4. Pull and run Emporous content:\n"
pullAndRun
# "5. Publish a CVE for previously published content"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "5. Publish a CVE for previously published content:\n"
buildAndPushCVE
# "6. Discover the CVE \n"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "6. Discover the CVE:\n"
checkCVE
# "7. Publish an updated Emporous Collection"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "6. Build an Emporous Collection from an updated appliation\n"
buildV2
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "7. Publish application:\n"
publishApp
# "8. Discover, update, and run the updated content"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "7. Discover, pull, and run updated application:\n"
discoverApps
pullAndRun
# End
endDemo

