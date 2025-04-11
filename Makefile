CONTAINER ?= groles-ci

run: roles.json
.PHONY: run

lint:
	shellcheck groles
.PHONY: lint

ci:
	docker container rm --force "$(CONTAINER)" &>/dev/null || true
	docker build --tag "$(CONTAINER)" .
	docker run --name "$(CONTAINER)" "$(CONTAINER)" make lint run
	docker cp "$(CONTAINER)":/app/roles.json .
	docker container rm --force "$(CONTAINER)"
.PHONY: ci

roles.json: understanding-roles.js
	flyscrape run ./understanding-roles.js > roles.json
