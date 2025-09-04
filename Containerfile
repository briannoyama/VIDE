FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
        software-properties-common \
    && apt-get update && apt-get install -y \
        build-essential \
        cmake \
        curl \
        ffmpeg \
	gettext \
        git \
        make \
        man-db \
        mjpegtools \
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

# Golang game dev dependencies
# Note: unable to specify golang version via homebrew.
RUN apt-get update && bash -c 'apt-get install -y \
        gcc-mingw-w64 \
        libsdl2-{image,mixer,ttf,gfx}-dev \
        libgl1-mesa-dev \
        '\
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
    && brew install golang \
    && go install golang.org/x/tools/gopls@latest \
    && go install github.com/incu6us/goimports-reviser/v3@latest \
    && go install mvdan.cc/gofumpt@latest \
    && go install github.com/segmentio/golines@latest \
    && go install github.com/go-delve/delve/cmd/dlv@latest \
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

# Tiny go for smaller binary
RUN wget https://github.com/tinygo-org/tinygo/releases/download/v0.39.0/tinygo_0.39.0_amd64.deb \
  && dpkg -i tinygo_0.39.0_amd64.deb \
  && rm tinygo_0.39.0_amd64.deb

RUN git clone --depth=1 -b release-0.11 --single-branch https://github.com/neovim/neovim \
    && (cd neovim && make && make install) && rm -R neovim

COPY ./nvim /root/.config/nvim/

# Set up bash
RUN cat /root/.config/nvim/.bashrc >> /root/.bashrc \
    && rm /root/.config/nvim/.bashrc \
    && echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc \
    && apt-get install -y locales \
    && locale-gen en_US.UTF-8

RUN nvim --headless +qall
    

