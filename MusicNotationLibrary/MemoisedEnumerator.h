@import Foundation;


@interface MemoisedEnumerator : NSEnumerator
-(NSUInteger)previousIndex;
-(NSUInteger)nextIndex;
-(id)previousObject;

- (MemoisedEnumerator *)initWith:(NSEnumerator *)anEnumerator memory:(NSMutableArray *)aMemory;

- (id)firstObject;

- (void)reset;

+ (MemoisedEnumerator *)with:(NSEnumerator *)enumerator;

+ (MemoisedEnumerator *)with:(NSEnumerator *)enumerator memory:(NSMutableArray *)memory;

@end