#!/usr/bin/env bash
set -Eeuo pipefail

INPUT_FILE=roles.json

get_roles() {
    jq '.[0].data.roles' < "${INPUT_FILE}"
}

get_headings() {
    get_roles | jq --raw-output 'map(.title + " (" + .id + ")") | join("\n---\n")'
}

get_details() {
    get_roles | jq --raw-output '
        map(
            [
                "Title: " + .title,
                "ID: " + .id,
                "Description: " + .description,
                "Beta: " + (.is_beta | tostring),
                "Permissions:",
                (.permissions | map("  * " + .) | join("\n"))
            ] | join("\n")
        )
        | join("\n---\n")
    '
}

main() {
    get_details
}

main
