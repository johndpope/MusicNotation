@import Foundation;


@interface MapEnumerator : NSEnumerator
- (MapEnumerator *)initWithEnumerator:(NSEnumerator *)anEnumerator andFunction:(id (^)(id))aFunc;

+ (NSEnumerator *)withEnumerator:(NSEnumerator *)enumerator andFunction:(id (^)(id))func;
@end