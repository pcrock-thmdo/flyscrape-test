CONTAINER ?= groles-ci

scrape: roles.json
.PHONY: scrape

lint:
	shellcheck groles
.PHONY: lint

ci:
	docker container rm --force "$(CONTAINER)" &>/dev/null || true
	docker build --tag "$(CONTAINER)" .
	docker run --name "$(CONTAINER)" "$(CONTAINER)" make lint scrape
	docker cp "$(CONTAINER)":/app/roles.json .
	docker container rm --force "$(CONTAINER)"
.PHONY: ci

release:
	./bin/release.sh
.PHONY: release

upload-artifacts: roles.json.gz
	gh release upload "$(shell gh release list --limit 1 --exclude-drafts --exclude-pre-releases --json tagName --template '{{range .}}{{.tagName}}{{end}}')" \
		groles roles.json.gz
.PHONY: upload-artifacts

roles.json:
	flyscrape run ./scrape.js > roles.json

roles.json.gz: roles.json
	gzip --keep roles.json
