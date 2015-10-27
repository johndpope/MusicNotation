@import Foundation;

@interface PairEnumerator : NSEnumerator
- (PairEnumerator *)initWithLeft:(NSEnumerator *)leftEnumerator right:(NSEnumerator *)rightEnumerator;

+(PairEnumerator *)withLeft:(NSEnumerator *)leftEnumerator right:(NSEnumerator *)rightEnumerator;
@end