@import Foundation;


@interface FlattenEnumerator : NSEnumerator
- (FlattenEnumerator *)initWithEnumerator:(NSEnumerator *)anEnumerator;

+ (NSEnumerator *)withEnumerator:(NSEnumerator *)enumerator;
@end