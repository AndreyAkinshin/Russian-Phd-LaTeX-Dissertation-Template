FROM ubuntu:latest
MAINTAINER Dmitry Tonkonogov <tonkonogovdv@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

COPY provision/installation.profile provision/packages.list /

RUN apt-get update \
    && apt-get install wget perl make -y \
    && useradd --create-home --shell /bin/bash user \
    && cd /opt \ 
    && wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xvf install-tl-unx.tar.gz \
    && rm install-tl-unx.tar.gz \
    && mv install-tl-* install-tl \
    && mv /installation.profile /opt/install-tl/installation.profile \
    && mv /packages.list /opt/install-tl/packages.list \
    && mkdir -p /opt/texlive/2016 \
    && chown -R user * 

USER user

RUN cd /opt/install-tl \
    && ./install-tl --profile installation.profile \
    && /opt/texlive/2016/bin/x86_64-linux/tlmgr install $(grep '' packages.list | tr '\n' ' ') 

ENV PATH /opt/texlive/2016/bin/x86_64-linux:$PATH

WORKDIR /data
VOLUME ["data"]

CMD ["make", "pdflatex"]