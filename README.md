VIDE
====

USAGE
-----

Made for `podman`. Requires `podman`, `docker` or other OCI implementation. Run the following in the base directory:

- `make` (or `make build`) : build the docker image
- `make linux-debug` : run in a manner allowing modification of the custom lua configs + other commands
- `make linux-ide` : run the linux IDE
- `make clean` : removes the built image (but not intermediate images)

Use `podman image prune --all` to clean up intermediate images.

Notes
-----

Containerized Neovim setup for golang based on [dreamsofcode-io/neovim-go-config](https://github.com/dreamsofcode-io/neovim-go-config). There are a few key differences:

- This implementation avoids [mason](https://github.com/williamboman/mason.nvim), since it does not load packages synchronously making it difficult to use in container run commands.
- Several packages related to game programming are installed, along with other customizations like my preferred PS1.
