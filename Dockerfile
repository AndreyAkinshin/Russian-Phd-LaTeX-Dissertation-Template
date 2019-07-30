FROM raabf/texstudio-versions:texlive2018
RUN echo 'deb http://deb.debian.org/debian/ buster  contrib non-free' >> /etc/apt/sources.list
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections 
RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy fonts-liberation ttf-mscorefonts-installer
RUN fc-cache -f -v
