# SQLiteRecoveryAI — Native iOS / CI Build

Native SwiftUI architecture for:
- SQLite DB / SQLite3
- WAL / SHM
- SQL
- JSON / XML
- folder import
- read-only diagnostics
- SQLite recovery
- recovery verification
- SQLite-AI local inference
- no Grok/X.AI integration

## Important
This repository is a build scaffold. A signed installable IPA requires Apple signing credentials and a macOS/Xcode build runner. The GitHub Actions workflow supports unsigned/archive builds by default.

## SQLite recovery sources
Run `./fetch_sqlite.sh` to download the official SQLite sources. The full-source archive supplies the required `ext/recover/sqlite3recover.c`, `sqlite3recover.h`, and `dbdata.c` files; the amalgamation supplies `sqlite3.c` and `sqlite3.h`. `make sqlite-recovery` compiles all three recovery sources with `SQLITE_ENABLE_DBPAGE_VTAB`, which is required for the `sqlite_dbpage` virtual table used by recovery.

See `SQLite/README.md` and `Makefile` for the reproducible source and build steps.

SQLite-AI 1.0.8 is the pinned AI dependency target.
