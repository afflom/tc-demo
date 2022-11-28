FROM fedora AS builder

RUN dnf install -y \
    wget

RUN wget https://github.com/containerd/containerd/releases/download/v1.6.10/containerd-1.6.10-linux-amd64.tar.gz \
    && tar xvf containerd-1.6.10-linux-amd64.tar.gz

FROM fedora

RUN dnf install -y \
    go \
    which \
    pv \
    asciinema \
    make \
    runc \
    jq \
    wget

COPY --from=builder --chmod=0700 /bin/containerd /usr/local/bin

COPY . .

WORKDIR /resources/scripts/

RUN "./build-environment.sh"

ENTRYPOINT [ "./launch-recording.sh" ]