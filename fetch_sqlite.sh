#!/bin/bash
set -euo pipefail

# Download matching official SQLite distributions and prepare every source file
# required by sqlite3recover. The amalgamation does not contain ext/recover.
mkdir -p SQLite
VERSION="${SQLITE_VERSION:-3510100}"
YEAR="${SQLITE_YEAR:-2026}"
BASE_URL="https://www.sqlite.org/${YEAR}"

AMALGAMATION="/tmp/sqlite-amalgamation-${VERSION}.zip"
FULL_SOURCE="/tmp/sqlite-src-${VERSION}.zip"
rm -rf "/tmp/sqlite-amalgamation-${VERSION}" "/tmp/sqlite-src-${VERSION}"

curl --fail --location --show-error --silent \
  "${BASE_URL}/sqlite-amalgamation-${VERSION}.zip" -o "$AMALGAMATION"
unzip -q -o "$AMALGAMATION" -d /tmp

AMALGAMATION_DIR="/tmp/sqlite-amalgamation-${VERSION}"
cp "$AMALGAMATION_DIR/sqlite3.c" SQLite/sqlite3.c
cp "$AMALGAMATION_DIR/sqlite3.h" SQLite/sqlite3.h

# sqlite3recover.c, sqlite3recover.h and dbdata.c are only shipped in the
# full-source archive and must come from the same SQLite release.
curl --fail --location --show-error --silent \
  "${BASE_URL}/sqlite-src-${VERSION}.zip" -o "$FULL_SOURCE"
unzip -q -o "$FULL_SOURCE" -d /tmp

FULL_DIR="/tmp/sqlite-src-${VERSION}"
for file in sqlite3recover.c sqlite3recover.h dbdata.c; do
  cp "$FULL_DIR/ext/recover/$file" "SQLite/$file"
done

# Fail early if a future SQLite archive changes its layout.
for file in sqlite3.c sqlite3.h sqlite3recover.c sqlite3recover.h dbdata.c; do
  test -s "SQLite/$file" || { echo "Missing SQLite/$file" >&2; exit 1; }
done

echo "Prepared official SQLite ${VERSION} sources in SQLite/."
