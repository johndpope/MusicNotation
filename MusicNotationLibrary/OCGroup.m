#import "OCGroup.h"

@implementation OCGroup
@synthesize key;

- (OCGroup*)initWithKey:(id<NSObject>)aKey enumerable:(id<Enumerable>)anEnumerable
{
    self = [super initWith:anEnumerable];
    if(self)
    {
        self.key = aKey;
    }
    return self;
}

+ (OCGroup*)group:(id)key enumerable:(id<Enumerable>)enumerable
{
    return [[OCGroup alloc] initWithKey:key enumerable:enumerable];
}
@end