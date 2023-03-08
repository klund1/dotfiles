FROM ubuntu:22.04

ARG UNAME=stealthadmin
ARG UID=999
ARG GID=999

RUN apt-get update && apt-get install -y sudo
RUN groupadd -g $GID -o $UNAME
RUN echo useradd --create-home --non-unique --uid $UID --gid $GID $UNAME
RUN useradd --create-home --non-unique --uid $UID --gid $GID $UNAME
RUN adduser $UNAME sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER $UNAME
RUN sudo apt-get update
