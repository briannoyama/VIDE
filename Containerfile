FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
        software-properties-common \
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

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install jj

RUN git clone --depth=1 -b release-0.10 --single-branch https://github.com/neovim/neovim \
    && (cd neovim && make && make install) && rm -R neovim \
    && git clone --depth=1 -b v2.0 --single-branch https://github.com/NvChad/NvChad \
        /root/.config/nvim \
    && rm -R /root/.config/nvim/.git

# Golang game dev dependencies
# Note: unable to specify golang version via homebrew.
RUN apt-get update && bash -c 'apt-get install -y \
        gcc-mingw-w64 \
        libsdl2-{image,mixer,ttf,gfx}-dev \
        libgl1-mesa-dev \
        '\
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install golang \
    && go install golang.org/x/tools/gopls@v0.18.1 \
    && go install github.com/incu6us/goimports-reviser/v3@v3.9.1 \
    && go install mvdan.cc/gofumpt@v0.8.0 \
    && go install github.com/segmentio/golines@v0.12.2 \
    && go install github.com/go-delve/delve/cmd/dlv@v1.24.2 \
    && cp -R /root/go/bin/* /usr/local/bin/ 

# Language servers + formaters + linters
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install bash-language-server \
	lua-language-server \
	marksman \
	prettier \
	pyright \
	stylua \
        terraform-ls \
	terragrunt \
	tfenv \
	typescript-language-server \
        yaml-language-server \
	yamllint \
	yamlfix \
	yapf \
    && tfenv install 1.5.5 \
    && tfenv use 1.5.5

# Odin support (note build script requires full clone of repo)
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install odin \
    && git clone -b master --single-branch https://github.com/DanielGavin/ols \
    && (cd ols && ./build.sh && ./odinfmt.sh) \ 
    && (cd ols && cp ols /usr/local/bin/ols && cp odinfmt /usr/local/bin/odinfmt)\
    && rm -R ols

COPY ./custom /root/.config/nvim/lua/custom

RUN cat /root/.config/nvim/lua/custom/.bashrc >> /root/.bashrc \
    && rm /root/.config/nvim/lua/custom/.bashrc \
    && echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc

RUN nvim --headless +qall
    

