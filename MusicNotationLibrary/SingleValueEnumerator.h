@import Foundation;


@interface SingleValueEnumerator : NSEnumerator
- (SingleValueEnumerator *)initWithValue:(id)aValue;

+ (id)singleValue:(id)value;
@end