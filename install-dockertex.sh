#!/bin/sh

# 1. Установка Docker и Git
echo "==> Installing Docker and Git packages"
sudo add-apt-repository universe 
sudo apt-get update
sudo apt-get install -qy docker.io git
sudo usermod -a -G docker $USER

# 2. Установка DockerTex
echo "==> Downloading and updating docker image"
sg docker -c "docker build -t raabf/texstudio-versions:texlive2018 ."

# 3. Настройка DockerTex
## 3.1 Клонирование репозитория
echo "==> Downloading dockertex"
DOWNLOADS_DIR=$(xdg-user-dir DOWNLOAD)
cd $DOWNLOADS_DIR && git clone https://github.com/raabf/dockertex.git

echo "==> Registering dockertex commands and shortcuts"
## 3.2 Регистрация в системе - добавление команд dockertex и dockertexstudio
sudo $DOWNLOADS_DIR/dockertex/install.sh --system --menu-volume DockerTexLive2018 --menu-tag texlive2018

echo "==> Fixing start of TexStudio"
## 3.3 Исправление для запуска TexStudio
sudo sed -i '/--net=host\ \\/d' /usr/local/bin/dockertexstudio

## 3.4 Добавление переменной окружения с указанием версии DockerTex
echo "==> Adding DockerTex tag to environment variables"
echo "export DOCKERTEX_DEFAULT_TAG=texlive2018" >> ~/.profile
echo "export DOCKERTEX_DEFAULT_TAG=texlive2018" >> ~/.bashrc

