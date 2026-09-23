#!/bin/bash
set -euo pipefail

mkdir -p SQLite

# Pin this to the SQLite release used by the project.
# Update the version and SHA-3/SHA-256 verification when upgrading.
VERSION="${SQLITE_VERSION:-3510100}"
URL="https://www.sqlite.org/2026/sqlite-amalgamation-${VERSION}.zip"

curl -fL "$URL" -o /tmp/sqlite.zip
unzip -o /tmp/sqlite.zip -d /tmp/sqlite-src

SRC="/tmp/sqlite-src/sqlite-amalgamation-${VERSION}"
cp "$SRC/sqlite3.c" SQLite/
cp "$SRC/sqlite3.h" SQLite/

# Recovery extension source files come from the corresponding SQLite source tree.
# A full-source distribution is required for these files.
FULL_URL="https://www.sqlite.org/2026/sqlite-src-${VERSION}.zip"
curl -fL "$FULL_URL" -o /tmp/sqlite-src.zip
unzip -o /tmp/sqlite-src.zip -d /tmp/sqlite-full

FULL="/tmp/sqlite-full/sqlite-src-${VERSION}"
cp "$FULL/ext/recover/sqlite3recover.c" SQLite/
cp "$FULL/ext/recover/sqlite3recover.h" SQLite/
cp "$FULL/ext/recover/dbdata.c" SQLite/

echo "SQLite sources prepared."
