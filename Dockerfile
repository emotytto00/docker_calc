FROM ubuntu:latest
LABEL authors="johan"

ENTRYPOINT ["top", "-b"]