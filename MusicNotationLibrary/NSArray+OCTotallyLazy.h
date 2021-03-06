@import Foundation;
#import "Option.h"
#import "Mappable.h"
#import "Flattenable.h"
#import "Types.h"
@class Sequence;
@class Pair;

@interface NSArray (OCTotallyLazy) <Mappable, Foldable, Enumerable, Flattenable>
- (NSArray*)add:(id)value;
- (NSArray*)cons:(id)value;
- (NSArray*)drop:(NSUInteger)toDrop;
- (NSArray*)dropWhile:(PREDICATE)funcBlock;
- (NSArray*)filter:(PREDICATE)filterBlock;
- (Option*)find:(PREDICATE)filterBlock;
- (NSArray*)flatMap:(FUNCTION1)functorBlock;
- (NSArray*)flatten;
- (id)fold:(id)value with:(id (^)(id accumulator, id item))functorBlock;
//- (void)foreach:(void (^)(id))funcBlock;
- (void)foreach:(void (^)(id element, NSUInteger index, BOOL* stop))funcBlock;
- (BOOL)isEmpty;
- (NSArray*)groupBy:(FUNCTION1)groupingBlock;
- (NSArray*)grouped:(NSUInteger)n;
- (id)head;
- (Option*)headOption;
- (NSArray*)join:(id<Enumerable>)toJoin;
- (NSArray*)concat:(id<Enumerable>)toJoin;
- (id)mapWithIndex:(id (^)(id, NSInteger))funcBlock;
- (Pair*)partition:(PREDICATE)toJoin;
- (id)reduce:(id (^)(id, id))functorBlock;
- (NSArray*)reverse;
- (Pair*)splitAt:(NSUInteger)splitIndex;
- (Pair*)splitOn:(id)splitItem;
- (Pair*)splitWhen:(PREDICATE)predicate;
- (NSArray*)tail;
- (NSArray*)take:(NSUInteger)n;
- (NSArray*)takeWhile:(PREDICATE)funcBlock;
- (NSArray*)takeRight:(NSUInteger)n;
- (NSString*)toString;
- (NSString*)toString:(NSString*)separator;
- (NSString*)toString:(NSString*)start separator:(NSString*)separator end:(NSString*)end;
- (NSArray*)zip:(NSArray*)otherSequence;
- (NSArray*)zipWithIndex;

- (Sequence*)asSequence;
- (NSSet*)asSet;
- (NSArray*)asArray;
- (NSDictionary*)asDictionary;

@end

inline static NSArray* array(id items, ...)
{
    NSMutableArray* array = [NSMutableArray array];
    va_list args;
    va_start(args, items);
    for(id arg = items; arg != nil; arg = va_arg(args, id))
    {
        [array addObject:arg];
    }
    va_end(args);
    return array;
}
