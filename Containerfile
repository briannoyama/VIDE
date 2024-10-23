FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
        software-properties-common \
    && yes | add-apt-repository ppa:longsleep/golang-backports \
    && apt-get update && bash -c 'apt-get install -y \
        build-essential \
        cmake \
        curl \
        gettext \
        git \
        gcc-mingw-w64 \
        golang-go \
        libsdl2-{image,mixer,ttf,gfx}-dev \
        libgl1-mesa-dev \
        make \
        man-db \
        ninja-build \
        unminimize \
        unzip \
        wget \
        ' \
    && yes | unminimize

RUN git clone --depth=1 -b release-0.10 --single-branch https://github.com/neovim/neovim \
    && (cd neovim && make && make install) && rm -R neovim \
    && git clone --depth=1 -b v2.0 --single-branch https://github.com/NvChad/NvChad \
        /root/.config/nvim \
    && rm -R /root/.config/nvim/.git

RUN go install golang.org/x/tools/gopls@v0.16.2 \
    && go install github.com/incu6us/goimports-reviser/v3@v3.6.5 \
    && go install mvdan.cc/gofumpt@v0.7.0 \
    && go install github.com/segmentio/golines@v0.12.2 \
    && go install github.com/go-delve/delve/cmd/dlv@v1.23.1
    
COPY ./custom /root/.config/nvim/lua/custom

RUN nvim --headless +qall
    
RUN echo '\n'"source /etc/bash_completion.d/git-prompt"\
    '\n'PS1="'"'\[\e[1;35m\]\u@dev\[\e[0;37m\] \[\e[7;37m\]$(__git_ps1 "%s")\[\e[0;37m\] \[\e[1;34m\]\w\[\e[m\] \$ '"'" >> /root/.bashrc \
    && echo 'PATH=/root/go/bin:$PATH' >> /root/.bashrc


