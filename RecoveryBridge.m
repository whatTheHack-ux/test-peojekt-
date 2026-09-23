#import "RecoveryBridge.h"
#import "sqlite3.h"
#import "sqlite3recover.h"

@implementation RecoveryBridge

+ (void)recover:(NSString *)sourcePath
      outputPath:(NSString *)outputPath
      completion:(SRRecoveryCompletion)completion {

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sqlite3 *db = NULL;
        int rc = sqlite3_open_v2(sourcePath.fileSystemRepresentation,
                                 &db,
                                 SQLITE_OPEN_READONLY,
                                 NULL);
        if (rc != SQLITE_OK || !db) {
            NSString *msg = db ? [NSString stringWithUTF8String:sqlite3_errmsg(db)]
                               : @"Unable to open database";
            if (db) sqlite3_close(db);
            completion(nil, [NSError errorWithDomain:@"SQLiteRecovery"
                                                code:rc
                                            userInfo:@{NSLocalizedDescriptionKey: msg}]);
            return;
        }

        sqlite3_recover *r = sqlite3_recover_init(
            db, "main", outputPath.fileSystemRepresentation
        );

        if (!r) {
            NSString *msg = [NSString stringWithUTF8String:sqlite3_errmsg(db)];
            sqlite3_close(db);
            completion(nil, [NSError errorWithDomain:@"SQLiteRecovery"
                                                code:1001
                                            userInfo:@{NSLocalizedDescriptionKey: msg ?: @"Recovery initialization failed"}]);
            return;
        }

        rc = sqlite3_recover_run(r);
        const char *cmsg = sqlite3_recover_errmsg(r);
        NSString *msg = cmsg ? [NSString stringWithUTF8String:cmsg] : nil;

        sqlite3_recover_finish(r);
        sqlite3_close(db);

        if (rc == SQLITE_OK) {
            completion(outputPath, nil);
        } else {
            completion(nil, [NSError errorWithDomain:@"SQLiteRecovery"
                                                code:rc
                                            userInfo:@{NSLocalizedDescriptionKey: msg ?: @"Recovery failed"}]);
        }
    });
}

@end
