#!/usr/bin/env bash

########################
# Demo prep: Check for demo dependencies
########################
if ! which go &>/dev/null
then
  printf "Golang binary not found.\nThis demo needs go to setup the environment"
  exit 1 
fi
if ! which make &>/dev/null
then
  printf "Make not found.\nThis demo needs make to build the Emporous client"
  exit 1 
fi
if ! which git &>/dev/null
then
  printf "Git not found.\nThis demo needs git to setup the environment"
  exit 1 
fi
if ! which pv &>/dev/null
then
  printf "pv not found.\nThis demo uses pv"
  exit 1 
fi
if ! which asciinema &>/dev/null
then
  printf "asciinema not found.\nThis demo uses asciinema for recording "
  exit 1 
fi

########################
# Demo prep: Clone and build Emporous client
########################

if ! ls client &>/dev/null
then
  if ! git clone https://github.com/jpower432/client.git -b feat/collection-spec
  then 
    echo "Emporous client repo clone failed"
    exit 1
  fi
  cd client

  if ! make build
  then 
    echo "Emporous client build failed"
    exit 1
  fi
  PATH=$PATH:$PWD/bin
  cd -
fi

########################
# Demo prep: Clone and build CNCF Distribution mod
########################

if ! ls distribution &>/dev/null
then
  git clone https://github.com/afflom/distribution.git -b add-attribute-endpoint
  cd distribution

  if ! make binaries
  then 
    echo "CNCF Distribution build failed"
    exit 1
  fi
  cd -
fi

########################
# Demo prep: Clone and build runc-attributes-wrapper
########################

if ! ls runc-attributes-wrapper &>/dev/null
then
  if ! git clone https://github.com/jpower432/runc-attributes-wrapper.git -b feat/initial-impl
  then 
    echo "RAW repo not cloned"
    exit 1
  fi
  cd runc-attributes-wrapper

  if ! make build
  then 
    echo "RAW not built"
    exit 1
  fi
  cd -
fi



echo "adding fake registry to hosts"

# Give the registry a name
echo '127.0.0.1 next.registry.io' >> /etc/hosts

echo "starting demo app v1 build"
## build demo apps
cd ../content/app/v1
if ! go build -o helloworld
then
  echo "appv1 not built"
  exit 1
fi
cd -

echo "starting demo app v2 build"

cd ../content/app/v2
if ! go build -o helloworld
then
  echo "appv2 not built"
  exit 1
fi
cd -

