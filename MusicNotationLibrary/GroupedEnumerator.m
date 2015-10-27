#import "OCTotallyLazy.h"
#import "GroupedEnumerator.h"


@implementation GroupedEnumerator {
    NSEnumerator *enumerator;
    int groupSize;
}

- (GroupedEnumerator *)initWithEnumerator:(NSEnumerator *)anEnumerator groupSize:(NSUInteger)aGroupSize {
    self = [super init];
    enumerator = anEnumerator;
    groupSize = aGroupSize;
    return self;
}

- (id)nextObject {
    int position = 0;
    id item;
    NSMutableArray *collect = [NSMutableArray array];
    while(position < groupSize && (item = enumerator.nextObject) != nil) {
        [collect addObject:item];
        position++;
    }

    return (position == 0) ? nil : collect;
}


+ (GroupedEnumerator *)with:(NSEnumerator *)enumerator groupSize:(NSUInteger)groupSize {
 return [[GroupedEnumerator alloc] initWithEnumerator:enumerator groupSize:groupSize];

}
@end