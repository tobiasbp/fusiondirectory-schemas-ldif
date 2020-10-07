NAME = tobiasbp/fusiondirectory-database-init
VERSION = 0.0.5

.PHONY: all build build-nocache

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .
