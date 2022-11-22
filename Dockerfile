FROM fedora

RUN dnf install -y \
    go \
    which \
    pv \
    asciinema \
    make \
    jq

COPY . .

ENTRYPOINT [ "./resources/scripts/launch-recording.sh" ]