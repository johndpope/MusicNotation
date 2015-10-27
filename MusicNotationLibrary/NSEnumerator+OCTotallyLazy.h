@import Foundation;
#import "Option.h"
#import "Predicates.h"

@interface NSEnumerator (OCTotallyLazy)
- (NSEnumerator*)drop:(NSUInteger)toDrop;
- (NSEnumerator*)dropWhile:(BOOL (^)(id))filterBlock;
- (NSEnumerator*)filter:(BOOL (^)(id))filterBlock;
- (NSEnumerator*)flatten;
- (NSEnumerator*)oct_map:(id (^)(id))func;

- (NSEnumerator*)take:(NSUInteger)n;
- (NSEnumerator*)takeWhile:(BOOL (^)(id))predicate;
- (Option*)find:(PREDICATE)predicate;

@end