run: roles.json
.PHONY: run

roles.json: understanding-roles.js
	flyscrape run ./understanding-roles.js > roles.json
