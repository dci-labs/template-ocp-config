#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-.}"
HOOKS_DIR="${TARGET_DIR}/.git/hooks"
SOURCE_HOOKS_DIR="${SCRIPT_DIR}/hooks"

usage() {
    echo "Usage: ${0} [TARGET_DIRECTORY]"
    echo ""
    echo "Install git hooks to a git repository."
    echo ""
    echo "Arguments:"
    echo "  TARGET_DIRECTORY  Path to the git repository (default: current directory)"
    echo ""
    echo "Examples:"
    echo "  ${0}                    # Install hooks in current repository"
    echo "  ${0} /path/to/repo      # Install hooks in specified repository"
    exit 1
}

if [[ "${1}" = "-h" ]] ||
   [[ "${1}" = "--help" ]]; then
    usage
fi

# Check if target is a git repository
if [[ ! -d "${TARGET_DIR}/.git" ]]; then
    echo "Error: ${TARGET_DIR} is not a git repository" >&2
    exit 1
fi

if [[ ! -d "${HOOKS_DIR}" ]]; then
    echo "Error: Git hooks directory not found at ${HOOKS_DIR}" >&2
    exit 1
fi

if [[ ! -d "${SOURCE_HOOKS_DIR}" ]]; then
    echo "Error: Source hooks directory not found at ${SOURCE_HOOKS_DIR}"
    exit 1
fi

echo "Installing git hooks to ${HOOKS_DIR}..."

for hook in "${SOURCE_HOOKS_DIR}"/*; do
    if [[ -f "${hook}" ]]; then
        hook_name=$(basename "${hook}")
        install -m 755 "${hook}" "${HOOKS_DIR}/${hook_name}"
    fi
done

echo ""
echo "Git hooks installed successfully!"
