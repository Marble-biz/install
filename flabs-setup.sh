#!/usr/bin/env bash
set -euo pipefail

FLABS_URL="https://api.github.com/repos/Marble-biz/flabs/contents/flabs"

if [ -z "${1:-}" ]; then
  echo "Usage: curl -sSL https://raw.githubusercontent.com/Marble-biz/install/main/flabs-setup.sh | bash -s -- <github-token>"
  echo ""
  echo "A GitHub personal access token with access to the Marble-biz organization is required."
  echo "Contact your administrator to obtain one."
  exit 1
fi

# Save the token for use by the environment
mkdir -p "${HOME}/.labs"
echo "$1" > "${HOME}/.labs/github-token"
chmod 600 "${HOME}/.labs/github-token"
echo "GitHub token saved."

# Fetch and run flabs setup using the provided token
export GITHUB_TOKEN="$1"
curl -sSL \
  -H "Authorization: Bearer $1" \
  -H "Accept: application/vnd.github.raw+json" \
  "${FLABS_URL}" | bash
