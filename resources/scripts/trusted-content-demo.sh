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

function prepMessage(){
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "\n"
  p "Prepping demo environment..."
  p ""
}

# Intro

function demoIntro(){
  clear
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=1
  p "Title: Emporous CVE reporting demo"
  p "This demo meets the following objectives:"
  p "1. Discover existing applications with Emporous"
  p "2. Pull and run latest Emporous content"
  p "3. Publish a CVE for previously published content"
  p "4. Discover the CVE"
  p "5. Discover all content affected by the CVE"
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
  p "\nINCOMING NOTIFICATION: A CVE with ID CVE-1337-1234 has just been published!\n"
}

function findCVE() {
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "User: Time to search for this filed CVE!"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "cat ../configs/cve-attribute-query.yaml"
  wait
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "uor-client-go create aggregate --schema-id=cve next.registry.io:5001 ../configs/cve-attribute-query.yaml --plain-http=true"
  wait
}

function findCVELinks() {
    DEMO_PROMPT=""
    PROMPT_TIMEOUT=3
    p "\nWhat applications does this CVE link to?\n"
    DEMO_PROMPT="$ "
    PROMPT_TIMEOUT=2
    pei "cat ../configs/cve-link-query.yaml"
    wait
    DEMO_PROMPT="$ "
    PROMPT_TIMEOUT=2
    pei "uor-client-go create aggregate next.registry.io:5001 ../configs/cve-link-query.yaml --plain-http=true"
    wait
}


# Pull and run Emporous content

function pullAndRun(){
  local DIGEST="${1:?DIGEST required}"
  local NAME="${2:?NAME required}"
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "Pull and run application using the Emporous runtime client:\n"
  DEMO_PROMPT="$ "
  PROMPT_TIMEOUT=2
  pei "rcl run --fetch=true --plain-http=true next.registry.io:5001/myorg/myapp@$DIGEST mycontainer$NAME"
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
  wait
  DEMO_PROMPT=""
  PROMPT_TIMEOUT=3
  p "\nNotice the link from the CVE to our application...\n"
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
  pei "uor-client-go create aggregate --schema-id=application next.registry.io:5001 ../configs/app-attribute-query.yaml --plain-http=true"
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

prepMessage

export PATH=$PATH:$PWD/demo-bin

# Start the registry

registry serve ./config-dev.yml > /output/registry.log 2>&1 &
#echo '127.0.0.1 next.registry.io' >> /etc/hosts

# Install containerd and runc
if ! wget https://github.com/containerd/containerd/releases/download/v1.6.10/containerd-1.6.10-linux-amd64.tar.gz > /output/install.log 2>&1
then
  echo "failed to pull containerd"
  exit 1
fi

if ! tar xvf containerd-1.6.10-linux-amd64.tar.gz > /output/install.log 2>&1
then
  echo "failed to install containerd"
  exit 1
fi

if ! dnf -y install runc >> /output/install.log 2>&1
then
  echo "failed to install runc"
  exit 1
fi

dnf -y install runc

# Start containerd
./bin/containerd > /output/containerd.log 2>&1 &

if ! uor-client-go build schema ../configs/cve-schema.yaml next.registry.io:5001/myorg/cves/schema:latest >> /output/install.log 2>&1
then
  echo "failed to build cve schema"
  exit 1
fi


if ! uor-client-go push --plain-http next.registry.io:5001/myorg/cves/schema:latest >> /output/install.log 2>&1
then
  echo "failed to push cve schema"
  exit 1
fi

if ! uor-client-go build schema ../configs/app-schema.yaml next.registry.io:5001/myorg/application/schema:latest >> /output/install.log 2>&1
then
  echo "failed to build app schema"
  exit 1
fi


if ! uor-client-go push --plain-http next.registry.io:5001/myorg/application/schema:latest >> /output/install.log 2>&1
then
  echo "failed to push app schema"
  exit 1
fi

if ! uor-client-go build collection -d ../configs/app-v1-dataset-config.yaml ../content/app/v1 next.registry.io:5001/myorg/myapp:1.0.0 --no-verify=true --plain-http=true >> /output/install.log 2>&1
then
  echo "failed to build v1 app"
  exit 1
fi


if ! uor-client-go push --plain-http next.registry.io:5001/myorg/myapp:1.0.0 >> /output/install.log 2>&1
then
  echo "failed to push v1 app"
  exit 1
fi

# Intro
demoIntro
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "User: Discovering available applications with Emporous...\n"
discoverApps
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "\nUser: Let's run the latest version of myapp as a container\n"
pullAndRun "sha256:51c28779dc4c4246f9642d9262e150093bd58be1b8a6579e232478076f9e91a5" "1.0.0"
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "\nApp Publisher: We found a bug in V1. Let's publish the new version\n"
buildV2
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "\nSecurity Team: We are filing a CVE against myapp. Here it comes!\n"
buildAndPushCVE
checkCVE
DEMO_PROMPT=""
PROMPT_TIMEOUT=3
p "\nUser: I wonder what applications in my registry are affected by this CVE.\n"
findCVE
findCVELinks

# End
endDemo

