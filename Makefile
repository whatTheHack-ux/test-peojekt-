# SQLite recovery native build
#
# The sqlite3recover extension requires sqlite3.c to be compiled with
# SQLITE_ENABLE_DBPAGE_VTAB. Run ./fetch_sqlite.sh first when SQLite/ is empty.

CC ?= cc
CFLAGS ?= -O2
SQLITE_CFLAGS = $(CFLAGS) -DSQLITE_ENABLE_DBPAGE_VTAB

SQLITE_OBJECTS = SQLite/sqlite3.o SQLite/dbdata.o SQLite/sqlite3recover.o

.PHONY: sqlite-recovery clean

sqlite-recovery: $(SQLITE_OBJECTS)
	@echo "Built sqlite3recover with SQLITE_ENABLE_DBPAGE_VTAB"

SQLite/sqlite3.o: SQLite/sqlite3.c SQLite/sqlite3.h
	$(CC) $(SQLITE_CFLAGS) -c $< -o $@

SQLite/dbdata.o: SQLite/dbdata.c SQLite/sqlite3.h
	$(CC) $(SQLITE_CFLAGS) -c $< -o $@

SQLite/sqlite3recover.o: SQLite/sqlite3recover.c SQLite/sqlite3recover.h SQLite/sqlite3.h
	$(CC) $(SQLITE_CFLAGS) -c $< -o $@

clean:
	rm -f $(SQLITE_OBJECTS)
