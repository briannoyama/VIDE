FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
        software-properties-common \
    && yes | add-apt-repository ppa:longsleep/golang-backports \
    && apt-get update && apt-get install -y \
        build-essential \
        cmake \
        curl \
        gettext \
        git \
        make \
        man-db \
        ninja-build \
        ripgrep \
        unminimize \
        unzip \
        wget \
        xclip \
    && yes | unminimize

RUN git clone --depth=1 -b release-0.10 --single-branch https://github.com/neovim/neovim \
    && (cd neovim && make && make install) && rm -R neovim \
    && git clone --depth=1 -b v2.0 --single-branch https://github.com/NvChad/NvChad \
        /root/.config/nvim \
    && rm -R /root/.config/nvim/.git

# Golang game dev dependencies
RUN apt-get update && bash -c 'apt-get install -y \
        gcc-mingw-w64 \
        golang-go  \
        libsdl2-{image,mixer,ttf,gfx}-dev \
        libgl1-mesa-dev \
        '\
    && go install golang.org/x/tools/gopls@v0.18.1 \
    && go install github.com/incu6us/goimports-reviser/v3@v3.9.1 \
    && go install mvdan.cc/gofumpt@v0.8.0 \
    && go install github.com/segmentio/golines@v0.12.2 \
    && go install github.com/go-delve/delve/cmd/dlv@v1.24.2 \
    && cp -R /root/go/bin/* /usr/local/bin/ 

# Lua dependencies
RUN wget https://github.com/JohnnyMorganz/StyLua/releases/download/v2.1.0/stylua-linux-x86_64.zip \
    && unzip stylua-linux-x86_64.zip -d /usr/local/bin \
    && rm stylua-linux-x86_64.zip \
    && wget https://github.com/LuaLS/lua-language-server/releases/download/3.14.0/lua-language-server-3.14.0-linux-x64.tar.gz \
    && mkdir /usr/share/lua-language-server \
    && tar -xf lua-language-server-3.14.0-linux-x64.tar.gz -C /usr/share/lua-language-server \
    && ln -s /usr/share/lua-language-server/bin/lua-language-server /usr/local/bin/lua-language-server \
    && rm lua-language-server-3.14.0-linux-x64.tar.gz
    
COPY ./custom /root/.config/nvim/lua/custom

RUN cat /root/.config/nvim/lua/custom/.bashrc > /root/.bashrc \
    && rm /root/.config/nvim/lua/custom/.bashrc

RUN nvim --headless +qall
    

