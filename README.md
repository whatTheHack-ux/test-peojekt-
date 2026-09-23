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
This repository is a build scaffold. A signed installable IPA requires Apple signing credentials and a macOS/Xcode build runner. The GitHub Actions workflow supports unsigned/archive builds by default and can be extended with App Store Connect signing secrets.

SQLite recovery uses the official SQLite recovery sources at build time:
`ext/recover/sqlite3recover.c`, `sqlite3recover.h`, `dbdata.c`, with `SQLITE_ENABLE_DBPAGE_VTAB`.

SQLite-AI 1.0.8 is the pinned AI dependency target.
