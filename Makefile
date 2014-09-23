all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build the browser-bundle image"
	@echo "   1. make install          - install launch wrappers"
	@echo "   2. make google-chrome    - launch google-chrome"
	@echo "   2. make tor-browser      - launch tor-browser"
	@echo "   2. make bash             - bash login"
	@echo ""

build:
	@docker build --tag=${USER}/browser-bundle .

install:
	@docker run -it --rm \
		--volume=/usr/local/bin:/target \
		${USER}/browser-bundle:latest install

google-chrome tor-browser bash:
	@docker run -it --rm \
		--env="USER_UID=$(shell id -u)" \
		--env="USER_GID=$(shell id -g)" \
		--env="DISPLAY=${DISPLAY}" \
		--volume=/tmp/.X11-unix:/tmp/.X11-unix \
		--volume=/run/user/$(shell id -u)/pulse:/run/pulse \
		${USER}/browser-bundle:latest $@
