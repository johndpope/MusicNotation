#import "Types.h"

@interface Numbers : NSObject
+ (FUNCTION2)min;

+ (FUNCTION2)max;

+ (FUNCTION2)sum;

+ (FUNCTION2)average;

+ (FUNCTION2)multiplyBy;

+ (FUNCTION1)multiplyBy:(NSNumber *)number;

+ (FUNCTION2)divideBy;

+ (FUNCTION1)divideBy:(NSNumber *)divisor;

+ (FUNCTION2)add;

+ (FUNCTION1)add:(NSNumber *)addition;

+ (FUNCTION2)subtract;

+ (FUNCTION1)substract:(NSNumber *)subtractor;
@end

inline static FUNCTION2 TL_max() {
    return [Numbers max];
}

inline static FUNCTION2 TL_min() {
    return [Numbers min];
}

inline static FUNCTION2 TL_sum() {
    return [Numbers sum];
}

inline static FUNCTION2 TL_average() {
    return [Numbers average];
}

inline static FUNCTION1 TL_multiplyBy(NSNumber *multiplier) {
    return [Numbers multiplyBy:multiplier];
}

inline static FUNCTION1 TL_divideBy(NSNumber *divisor) {
    return [Numbers divideBy:divisor];
}

inline static FUNCTION1 TL_add(NSNumber *addition) {
    return [Numbers add:addition];
}

inline static FUNCTION1 TL_subtract(NSNumber *subtractor) {
    return [Numbers substract:subtractor];
}

#ifdef TL_SHORTHAND
    #define min() TL_min()
    #define max() TL_max()
    #define sum() TL_sum()
    #define average() TL_average()
    #define multiplyBy(multiplier) TL_multiplyBy(multiplier)
    #define divideBy(divisor) TL_divideBy(divisor)
    #define add(addition) TL_add(addition)
    #define subtract(subtractor) TL_subtract(subtractor)
#endif