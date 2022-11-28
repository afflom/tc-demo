FROM fedora

RUN dnf install -y \
    go \
    which \
    pv \
    asciinema \
    make \
    runc \
    containerd \
    jq

COPY . .

WORKDIR /resources/scripts/

RUN "./build-environment.sh"

ENTRYPOINT [ "./launch-recording.sh" ]