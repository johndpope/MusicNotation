@import Foundation;
#import "Sequence.h"

@interface OCGroup : Sequence
@property (nonatomic, strong) id<NSObject> key;

- (OCGroup*)initWithKey:(id)aKey enumerable:(id<Enumerable>)anEnumerable;

+ (OCGroup*)group:(id)key enumerable:(id<Enumerable>)enumerable;

@end
