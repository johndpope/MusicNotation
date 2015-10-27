@import Foundation;

@interface GroupedEnumerator : NSEnumerator
- (GroupedEnumerator *)initWithEnumerator:(NSEnumerator *)anEnumerator groupSize:(NSUInteger)groupSize;

+ (GroupedEnumerator *)with:(NSEnumerator *)enumerator groupSize:(NSUInteger)groupSize;
@end