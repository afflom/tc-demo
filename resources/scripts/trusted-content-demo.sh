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
  pei "uor-client-go build collection -d ../configs/app-v1-dataset-config.yaml ../content/app/v1 next.registry.io:5001/myorg/myapp:1.0.0 --no-verify=true --plain-http=true"
  wait
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io:5001/myorg/myapp:1.0.0 --plain-http=true"
  wait
}


# Verify app CVEs prior to running
function checkCVE(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Poll the Emporous endpoint for vulnerability updates:\n"
  DEMO_PROMPT="$ "
    PROMPT_TIMEOUT=2
    pei "cat ../configs/cve-attribute-query.yaml"
    wait
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go create aggregate --schema-id=cve next.registry.io:5001 ../configs/cve-attribute-query.yaml --plain-http=true"
  wait
}


# Pull and run Emporous content

function pullAndRun(){
  local TAG="${1:?TAG required}"
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Pull and run application using the Emporous runtime client:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "rcl run --fetch=true --plain-http=true next.registry.io:5001/myorg/myapp:$TAG mycontainer"
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
  pei "uor-client-go build collection -d ../configs/cve-dataset-config.yaml ../content/cve next.registry.io:5001/myorg/cves:myapp-v1.0.0 --no-verify=true --plain-http=true"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Publish CVE with link:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push --plain-http=true next.registry.io:5001/myorg/cves:myapp-v1.0.0"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
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
  pei "uor-client-go build collection -d ../configs/app-v2-dataset-config.yaml ../content/app/v2 next.registry.io:5001/myorg/myapp:1.0.1 --no-verify=true --plain-http=true"
  wait
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io:5001/myorg/myapp:1.0.1 --plain-http=true"
  wait
}

function buildApp2(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Author dataset-config.yaml:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/app2-dataset-config.yaml"
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Add metadata to the updated application:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go build collection -d ../configs/app2-dataset-config.yaml ../content/app2/v1 next.registry.io:5001/myorg/app2:1.0.0 --no-verify=true --plain-http=true"
  wait
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go push next.registry.io:5001/myorg/app2:1.0.0 --plain-http=true"
  wait

  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go create inventory --plain-http=true next.registry.io:5001/myorg/app2:v1.0.0"
  wait
}


## Discover app update to v2
function discoverApps(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Poll the Emporous endpoint for application updates:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/app-attribute-query.yaml"
  wait
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go create aggregate --schema-id=core-descriptor next.registry.io:5001 ../configs/app-attribute-query.yaml --plain-http=true"
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


 registry serve ./distribution/cmd/registry/config-dev.yml > registry.log 2>&1 &
echo '127.0.0.1 next.registry.io' >> /etc/hosts

# Start containerd
containerd > containerd.log 2>&1 &

if ! uor-client-go build schema ../configs/cve-schema.yaml next.registry.io:5001/myorg/cves/schema:latest
then
  echo "failed to build cve schema"
  exit 1
fi

if ! uor-client-go push --plain-http next.registry.io:5001/myorg/cves/schema:latest
then
  echo "failed to push cve schema"
  exit 1
fi

# Intro
demoIntro
# "1. Build an Emporous Collection from an application"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "1. Build an Emporous Collection from an updated application\n"
buildV1
# "3. Discover applications with Emporous"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "3. Discover applications with Emporous:\n"
discoverApps
# "4. Pull and run Emporous content"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "4. Pull and run Emporous content:\n"
pullAndRun "1.0.0"
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
p "7. Build an Emporous Collection from an updated appliation\n"
buildV2
# "8. Discover, update, and run the updated content"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "8. Discover, pull, and run updated application:\n"
discoverApps
pullAndRun "1.0.1"

# "8. Discover, update, and run the updated content"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "9. Create a dependency relationship and discover that relationship:\n"
buildApp2
# End
endDemo

