USAGE
=====

Made for podman. Requires podman, docker or other OCI implementation.

- `make` (or `make build`) : build the docker image
- `make linux-debug` : run in a manner allowing modification of the custom lua configs + other commands
- `make linux-ide` : run the linux IDE
- `make clean` : removes the built image (but not intermediate images)

Use `podman image prune --all` to clean up intermediate images.  

Containerized Neovim setup for golang based on the following config:
https://github.com/dreamsofcode-io/neovim-go-config
