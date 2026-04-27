#!/usr/bin/env bash
# Usage: ./md_to_pdf.sh <input.md>
# Converts a markdown file to PDF using pandoc + xelatex.

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <input.md>"
  exit 1
fi

INPUT="$1"
OUTPUT="${INPUT%.md}.pdf"

pandoc "$INPUT" \
  -o "$OUTPUT" \
  --pdf-engine=xelatex \
  -V geometry:margin=1in \
  -V mainfont="Helvetica Neue" \
  -V fontsize=11pt \
  -V linkcolor=blue \
  -V urlcolor=blue

echo "Created: $OUTPUT"
