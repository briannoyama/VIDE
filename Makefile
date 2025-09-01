build:
	podman build . -t ide --ulimit nofile=8192:8192

linux-debug:
	-@xhost +local:
	-@podman run \
	  --device /dev/dri \
	  --env=DISPLAY \
	  --env=GEMINI_API_KEY \
	  --env=GEMINI_MODEL \
	  --env=TERM=xterm \
	  --interactive \
	  --net=host \
	  --rm \
	  --tty \
	  --volume=./:/root/VIDE \
	  --volume=$$HOME/Development:/root/Development \
	  --volume=./nvim:/root/.config/nvim/ \
	  --volume=$$HOME/.ssh/:/root/.ssh/ \
	  --volume=$$HOME/.cache/:/root/.cache/ \
	  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
	  --workdir /root \
	  'ide'
	-@xhost -local:
	
linux-ide:
	-@xhost +local:
	-@podman run \
	  --device /dev/dri \
	  --env=DISPLAY \
	  --env=GEMINI_API_KEY \
	  --env=GEMINI_MODEL \
	  --env=TERM=xterm \
	  --interactive \
	  --net=host \
	  --rm \
	  --tty \
	  --volume=$$HOME/Development:/root/Development \
	  --volume=$$HOME/.ssh/:/root/.ssh/ \
	  --volume=$$HOME/.cache/:/root/.cache/ \
	  --volume=/tmp/.X11-unix:/tmp/.X11-unix \
	  --workdir /root/$$BASE \
	  'ide' bash -i -exec 'source /root/.bashrc && nvim'
	-@xhost -local:

clean:
	podman rmi ide 
