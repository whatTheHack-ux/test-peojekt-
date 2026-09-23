#import <Foundation/Foundation.h>

typedef void (^SRRecoveryCompletion)(NSString * _Nullable recoveredPath,
                                      NSError * _Nullable error);

@interface RecoveryBridge : NSObject
+ (void)recover:(NSString *)sourcePath
      outputPath:(NSString *)outputPath
      completion:(SRRecoveryCompletion)completion;
@end
