image = devilbox/nginx-stable

help:
	@printf "%s\n" "make build:       Build"
	@printf "%s\n" "make rebuild:     Rebuild"
	@printf "%s\n" "make test:        Test"


build: pull
	docker build -t $(image) .
	cd build; ./gen-readme.sh $(image)

rebuild: pull
	docker build --no-cache -t $(image) .
	cd build; ./gen-readme.sh $(image)

tag:
	docker tag $(image) $(image):$(ARG)

test:
	.ci/start-ci.sh $(image) $(ARG)

pull:
	docker pull $(shell grep 'FROM' Dockerfile | sed 's/^FROM//g'; )
