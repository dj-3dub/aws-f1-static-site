#!/usr/bin/env bash
set -euo pipefail


# Renders docs/architecture.dot to both PNG and SVG in docs/
# Requires: graphviz (dot)
# Usage: ./render-diagram.sh


ROOT_DIR=$(cd "$(dirname "$0")" && pwd)
DOT_FILE="$ROOT_DIR/docs/architecture.dot"
PNG_OUT="$ROOT_DIR/docs/architecture.png"
SVG_OUT="$ROOT_DIR/docs/architecture.svg"


if ! command -v dot >/dev/null 2>&1; then
echo "Error: graphviz 'dot' is not installed.\nInstall it with: sudo apt-get update && sudo apt-get install -y graphviz" >&2
exit 1
fi


if [[ ! -f "$DOT_FILE" ]]; then
echo "Error: $DOT_FILE not found. Create it first." >&2
exit 1
fi


# PNG (good for README previews)
dot -Tpng "$DOT_FILE" -o "$PNG_OUT"
echo "Wrote: $PNG_OUT"


# SVG (crisp for zooming)
dot -Tsvg "$DOT_FILE" -o "$SVG_OUT"
echo "Wrote: $SVG_OUT"
