#!/usr/bin/env bash
set -Eeuo pipefail

INPUT_FILE=roles.json

get_roles() {
    # shellcheck shell=sh
    # the source of this function will be used inside fzf, executed by `sh` as well as `bash`
    jq '.[0].data.roles' < "${INPUT_FILE}"
}

get_headings() {
    get_roles | jq --raw-output 'map(.title + " (" + .id + ")") | join("\n")'
}

get_details() {
    # shellcheck shell=sh
    # the source of this function will be used inside fzf, executed by `sh` as well as `bash`
    local role_heading="${*}" jq_script role_id
    role_id="$(echo "${role_heading}" | grep --only-matching --perl-regexp '\(\S+\)')"
    jq_script="$(cat <<EOF
map(
    select(("(" + .id + ")") == "${role_id}")
)
| map(
    [
        "Title: " + .title,
        "ID: " + .id,
        "Description: " + .description,
        "Beta: " + (.is_beta | tostring),
        "Permissions:",
        (.permissions | map("  * " + .) | join("\n"))
    ] | join("\n")
)
| join("\n")
EOF
)"
    jq --raw-output "${jq_script}"
}

select_role() {
    local preview_cmd
    preview_cmd="
INPUT_FILE=${INPUT_FILE}
$(declare -f get_roles)
$(declare -f get_details)
get_roles | get_details {}"

    get_headings | SHELL="sh" fzf --preview "${preview_cmd}"
}

main() {
    local role_heading
    role_heading="$(select_role)"
    get_roles | get_details "${role_heading}"
}

main
