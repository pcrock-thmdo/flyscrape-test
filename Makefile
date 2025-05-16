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

release:
	gh release create \
		--generate-notes \
		--fail-on-no-commits \
		--target "$(shell git rev-parse --abbrev-ref HEAD)"
.PHONY: release

upload-artifacts: roles.json.gz
	gh release upload "$(shell gh release list --limit 1 --exclude-drafts --exclude-pre-releases --json tagName --template '{{range .}}{{.tagName}}{{end}}')" \
		groles roles.json.gz
.PHONY: upload-artifacts

roles.json: understanding-roles.js
	flyscrape run ./understanding-roles.js > roles.json

roles.json.gz: roles.json
	gzip --keep roles.json
