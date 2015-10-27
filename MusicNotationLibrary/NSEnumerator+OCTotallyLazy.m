#import "NSEnumerator+OCTotallyLazy.h"
#import "FlattenEnumerator.h"
#import "MapEnumerator.h"
#import "FilterEnumerator.h"
#import "Some.h"
#import "None.h"
#import "TakeWhileEnumerator.h"

@implementation NSEnumerator (OCTotallyLazy)

- (NSEnumerator*)drop:(NSUInteger)toDrop
{
    return [self dropWhile:TL_countTo(toDrop)];
}

- (NSEnumerator*)dropWhile:(PREDICATE)predicate
{
    return [self filter:TL_not(TL_whileTrue(predicate))];
}

- (NSEnumerator*)filter:(PREDICATE)predicate
{
    return [FilterEnumerator withEnumerator:self andFilter:predicate];
}

- (Option*)find:(PREDICATE)predicate
{
    for(id item in self)
    {
        if(predicate(item))
        {
            return [Some some:item];
        }
    }
    return [None none];
}

- (NSEnumerator*)flatten
{
    return [FlattenEnumerator withEnumerator:self];
}

- (NSEnumerator*)oct_map:(id (^)(id))func
{
    return [MapEnumerator withEnumerator:self andFunction:func];
}

- (NSEnumerator*)take:(NSUInteger)n
{
    return [self takeWhile:TL_countTo(n)];
}

- (NSEnumerator*)takeWhile:(BOOL (^)(id))predicate
{
    return [TakeWhileEnumerator with:self predicate:TL_whileTrue(predicate)];
}

@end