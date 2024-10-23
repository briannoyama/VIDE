build: Containerfile
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
	  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
	  --workdir /root \
	  'nvchad'
	@xhost -local:

linux-ide:
	@xhost +local:gamer
	@podman run \
	  --device /dev/dri \
	  --env=DISPLAY \
	  --env=TERM=xterm \
	  --interactive \
	  --net=host \
	  --rm \
	  --tty \
	  --volume=$$HOME/Development/go:/root/go \
	  --volume=$$HOME/.ssh/:/root/.ssh/ \
	  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
	  --workdir /root \
	  'nvchad' nvim
	@xhost -local:gamer

clean:
	podman rmi nvchad
