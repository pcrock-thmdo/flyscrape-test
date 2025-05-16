#!/usr/bin/env bash
set -euo pipefail

panic() {
    echo "FATAL: $*" >&2
    exit 1
}

main() {
    current_version="$(grep -o -P '(?<=GROLES_VERSION\=")\d+\.\d+\.\d+(?="$)' groles)" \
        || panic "Didn't find version constant in \`groles\`"
    if git tag | grep -F -x -q "v${current_version}"; then
        panic "Release ${current_version} already exists!"
    fi
    gh release create "v${current_version}" \
        --generate-notes \
        --fail-on-no-commits \
        --target "$(git rev-parse --abbrev-ref HEAD)"
}

main
