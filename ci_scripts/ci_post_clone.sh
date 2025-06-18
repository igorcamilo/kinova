#!/bin/sh

set -e

# Exit if TMDB_API_KEY is not set
if [ -z "$TMDB_API_KEY" ]; then
  echo "Error: TMDB_API_KEY environment variable not set"
  exit 1
fi

# Define the output file path
OUTPUT_FILE="Kinova/Secrets.swift"

# Write the Swift file
cat > "$OUTPUT_FILE" <<EOL
// This file is auto-generated. Do not edit.

enum Secrets {
    static let tmdbAPIKey = "$TMDB_API_KEY"
}
EOL

echo "Secrets.swift generated at $OUTPUT_FILE"
