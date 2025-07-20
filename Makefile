build:
	podman build . -t ide

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
	  --volume=./custom:/root/.config/nvim/lua/custom \
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
