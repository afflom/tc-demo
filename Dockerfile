FROM fedora

RUN dnf install -y \
    go \
    which \
    pv \
    asciinema \
    make \
    jq \
    wget

COPY . .

WORKDIR /resources/scripts/

RUN "./build-environment.sh"

ENTRYPOINT [ "./launch-recording.sh" ]