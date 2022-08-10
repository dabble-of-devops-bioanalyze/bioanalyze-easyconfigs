
build:
	docker build -t easybuild .

run: build
	docker run -it \
		-v $(shell pwd):/apps/easybuild \
		bash
