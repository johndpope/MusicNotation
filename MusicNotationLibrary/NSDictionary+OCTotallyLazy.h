@import Foundation;
#import "OCTotallyLazy.h"

@interface NSDictionary (Functional)
- (NSDictionary*)filterKeys:(BOOL (^)(id))functorBlock;
- (NSDictionary*)filterValues:(BOOL (^)(id))functorBlock;
- (void)foreach:(void (^)(id, id))funcBlock;
- (id)map:(NSArray* (^)(id, id))funcBlock;
- (id)mapValues:(id (^)(id))funcBlock;
- (Option*)optionForKey:(id)key;
@end

inline static NSDictionary* dictionary(Sequence* keys, Sequence* values)
{
    return [NSDictionary dictionaryWithObjects:[values asArray] forKeys:[keys asArray]];
}
