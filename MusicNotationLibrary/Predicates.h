#import "Types.h"

@interface Predicates : NSObject
+ (PREDICATE)alternate:(BOOL)startState;

+ (PREDICATE)andLeft:(PREDICATE)left withRight:(PREDICATE)right;

+ (PREDICATE)orLeft:(PREDICATE)left withRight:(PREDICATE)right;

+ (PREDICATE)countTo:(NSUInteger)n;

+ (PREDICATE)containedIn:(NSArray *)existing;

+ (PREDICATE)containsString:(NSString *)toMatch;

+ (PREDICATE)equalTo:(id)comparable;

+ (PREDICATE)everyNth:(NSUInteger)n;

+ (PREDICATE)greaterThan:(NSNumber *)comparable;

+ (PREDICATE)lessThan:(NSNumber *)comparable;

+ (PREDICATE)lessThanOrEqualTo:(NSNumber *)comparable;

+ (PREDICATE)not:(PREDICATE)predicate;

+ (PREDICATE)startsWith:(NSString *)prefix;

+ (PREDICATE)whileTrue:(PREDICATE)predicate;
@end

inline static PREDICATE TL_alternate(BOOL startState) {
    return [Predicates alternate:startState];
}
inline static PREDICATE TL_and(PREDICATE left, PREDICATE right) {
    return [Predicates andLeft:left withRight:right];
}
inline static PREDICATE TL_or(PREDICATE left, PREDICATE right) {
    return [Predicates orLeft:left withRight:right];
}
inline static PREDICATE TL_countTo(int n) {
    return [Predicates countTo:n];
}
inline static PREDICATE TL_containedIn(NSArray *existing) {
    return [Predicates containedIn:existing];
}
inline static PREDICATE TL_containsString(NSString *toMatch) {
    return [Predicates containsString:toMatch];
}
inline static PREDICATE TL_equalTo(id comparable) {
    return [Predicates equalTo:comparable];
}
inline static PREDICATE TL_everyNth(int n) {
    return [Predicates everyNth:n];
}
inline static PREDICATE TL_greaterThan(NSNumber *comparable) {
    return [Predicates greaterThan:comparable];
}
inline static PREDICATE TL_lessThan(NSNumber *comparable) {
    return [Predicates lessThan:comparable];
}
inline static PREDICATE TL_lessThanOrEqualTo(NSNumber *comparable) {
    return [Predicates lessThanOrEqualTo:comparable];
}
inline static PREDICATE TL_not(PREDICATE predicate) {
    return [Predicates not:predicate];
}
inline static PREDICATE TL_startsWith(NSString *prefix) {
    return [Predicates startsWith:prefix];
}
inline static PREDICATE TL_whileTrue(PREDICATE predicate) {
    return [Predicates whileTrue:predicate];
}

#ifdef TL_LAMBDA
    #define lambda(s, statement) ^(id s){return statement;}
#endif

#ifdef TL_LAMBDA_SHORTHAND
    #define _(statement) ^(id _){return statement;}
#endif

#ifdef TL_SHORTHAND
    #define alternate(startState) TL_alternate(startState)
    #define and(left, right) TL_and(left, right)
    #define containsStr(comparable) TL_containsString(comparable)
    #define countTo(comparable) TL_countTo(comparable)
    #define eqTo(comparable) TL_equalTo(comparable)
    #define everyNth TL_everyNth
    #define gtThan(comparable) TL_greaterThan(comparable)
    #define in(array) TL_containedIn(array)
    #define ltThan(comparable) TL_lessThan(comparable)
    #define not(predicate) TL_not(predicate)
    #define or(left, right) TL_or(left, right)
    #define startingWith(comparable) TL_startsWith(comparable)
#endif
