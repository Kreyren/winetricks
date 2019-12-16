FROM gentoo/stage3-amd64

USER root

RUN emerge --sync

RUN emerge xlogo
