
DOCKER=docker run -it --volume "${HOME}/.cargo:/root/.cargo/" --volume "${PWD}:/opt/shakshuka/" --workdir "/opt/shakshuka/" library/rust:1.50.0-slim

build:
	$(DOCKER) cargo build --target=x86_64-unknown-linux-gnu --release

build-docker-debug:
	docker build -t raytung/shakshuka:debug --target DEBUG .

build-docker:
	docker build . -t raytung/shakshuka:latest

clean:
	$(DOCKER) cargo clean

.PHONY: clean