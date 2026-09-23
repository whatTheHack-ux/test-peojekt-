# Official SQLite recovery sources

This directory is populated by `./fetch_sqlite.sh` from the matching official
SQLite release. `sqlite3recover.c`, `sqlite3recover.h`, and `dbdata.c` come from
the full SQLite source archive (`ext/recover`); they are not part of the
amalgamation archive.

Build the recovery objects with:

```sh
./fetch_sqlite.sh
make sqlite-recovery
```

The Makefile always supplies `-DSQLITE_ENABLE_DBPAGE_VTAB`. This is required by
`dbdata.c` and by `sqlite3recover.c`, because recovery reads pages through the
`sqlite_dbpage` virtual table.

The downloaded SQLite sources are intentionally not committed to this small
scaffold. Pin a release with `SQLITE_VERSION` and `SQLITE_YEAR` when creating a
reproducible build, for example:

```sh
SQLITE_VERSION=3510100 SQLITE_YEAR=2026 ./fetch_sqlite.sh
```
