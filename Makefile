build:
	podman build . -t nvchad
	
linux-debug:
	@xhost +local:
	-@podman run \
	  --device /dev/dri \
	  --env=DISPLAY \
	  --env=TERM=xterm \
	  --interactive \
	  --net=host \
	  --rm \
	  --tty \
	  --volume=$$HOME/Development/go:/root/go \
	  --volume=./custom:/root/.config/nvim/lua/custom \
	  --volume=$$HOME/.ssh/:/root/.ssh/ \
	  --volume=$$HOME/.cache/:/root/.cache/ \
	  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
	  --workdir /root \
	  'nvchad'
	@xhost -local:

linux-ide:
	@xhost +local:
	-@podman run \
	  --device /dev/dri \
	  --env=DISPLAY \
	  --env=TERM=xterm \
	  --interactive \
	  --net=host \
	  --rm \
	  --tty \
	  --volume=$$HOME/Development/go:/root/go \
	  --volume=$$HOME/.ssh/:/root/.ssh/ \
	  --volume=$$HOME/.cache/:/root/.cache/ \
	  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
	  --workdir /root/$$BASE \
	  'nvchad' bash -exec 'source .bashrc && nvim'
	@xhost -local:

clean:
	podman rmi nvchad
