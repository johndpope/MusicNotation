//
//  Rational.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

// comments help: http://www.cocoanetics.com/2011/11/amazing-apple-like-documentation/

@class Rational;

//======================================================================================================================
/** The `VFrational` class performs rationalal operations on a numerator and a denominator. It
 is useful for representing logic that involves rationals as opposed to floating point operations.

 The following demonstrates some basic usage of this class.

 */
@interface Rational : NSObject
{
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * Properties
 *  ---------------------------------------------------------------------------------------
 */

/** The multiplier is the integer that the numerator and denominator are both multiplied by before a rational has been
 simplified.
 @warning The logic for this property has not yet been implemented.
 */
@property (assign, nonatomic) NSUInteger multiplier;
@property (assign, nonatomic) NSUInteger numerator;
@property (assign, nonatomic) NSUInteger denominator;
@property (assign, nonatomic) BOOL positive;
@property (readonly, nonatomic) float floatValue;
@property (strong, nonatomic, getter=getSimplifiedString) NSString* simplifiedString;
@property (strong, nonatomic, getter=getMixedString) NSString* mixedString;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Standard Methods
 *  ---------------------------------------------------------------------------------------
 */

/** This is the first super-awesome method.

 You can also add lists, but have to keep an empty line between these blocks.

 - One
 - Two
 - Three

 @param string A parameter that is passed in.
 @return Whatever it returns.
 */
- (instancetype)initWithNumerator:(NSInteger)numerator andDenominator:(NSInteger)denominator;

/** This is the second super-awesome method.
 Note that there are additional cool things here, like [direct hyperlinks](http://www.cocoanetics.com)
 @param number A parameter that is passed in, almost as cool as someMethodWithString:
 @return Whatever it returns.
 @see someMethodWithString:

 @bug *Bug:* A yellow background.
 */
+ (Rational*)rationalWithNumerator:(NSInteger)numerator andDenominator:(NSInteger)denominator;

+ (Rational*)rationalWithNumerator:(NSInteger)numerator;

+ (Rational*)rationalZero;

+ (Rational*)rationalOne;

+ (Rational*)rationalWithRational:(Rational*)otherrational;

- (Rational*)clone;

/** Converts the rational numerator and denominator and to a float by performing division.
 @return Returns the float value when division is performed.
 */
- (float)floatValue;

- (BOOL)valueAsBool;

- (NSNumber*)numberValue;

#pragma mark - String operations
/**---------------------------------------------------------------------------------------------------------------------
 * @name String operations
 *  ---------------------------------------------------------------------------------------
 */
//
//- (NSString *)toString;
//
//- (NSString *)toSimplifiedString;

/**
 @warning *Warning:* The following method has not been implemented yet.
 */
//- (NSString *)toMixedString;

#pragma mark - Math operations
/**---------------------------------------------------------------------------------------------------------------------
 * @name Math operations
 *  ---------------------------------------------------------------------------------------
 */

- (void)set:(NSInteger)numerator and:(NSInteger)denominator;

+ (Rational*)simplify:(Rational*)rational;

- (Rational*)simplify;

- (Rational*)add:(Rational*)other;

+ (Rational*)add:(Rational*)param1 and:(Rational*)param2;

- (Rational*)addn:(NSUInteger)value;

- (Rational*)subtract:(Rational*)other;

+ (Rational*)subtract:(Rational*)param1 and:(Rational*)param2;

- (Rational*)subt:(NSUInteger)value;

- (Rational*)multiply:(Rational*)other;

+ (Rational*)multiply:(Rational*)param1 and:(Rational*)param2;

/*!
 *  Multiplies this Rational by another Rational
 *
 *  @param value another Rational
 *
 *  @return this Rational
 */
- (Rational*)mult:(NSUInteger)value;

- (Rational*)divide:(Rational*)other;

+ (Rational*)divide:(Rational*)param1 and:(Rational*)param2;

- (Rational*)divn:(NSUInteger)value;

#pragma mark - Comparison Operations
/**---------------------------------------------------------------------------------------------------------------------
 * @name Comparison operations
 *  ---------------------------------------------------------------------------------------
 */

- (BOOL)equalsFloat:(float)other;

+ (BOOL)equalsRational:(Rational*)rat1 and:(Rational*)rat2;

/** Determines if this rational is equivalent to another rational.
 @param other The other rational to compare this rational to.
 @return The result of the comparison
 */
- (BOOL)equalsRational:(Rational*)other;
- (BOOL)notEqualsRational:(Rational*)other;
- (BOOL)lt:(Rational*)other;

- (BOOL)gt:(Rational*)other;

- (BOOL)lte:(Rational*)other;

- (BOOL)gte:(Rational*)other;

/** is the numberat of this rational zero? YES or NO
 */
- (BOOL)zero;

/** Copies values of another rational into itself.
 @param sender The rational to be copied
 @return This rational
 */
- (Rational*)copy:(Rational*)sender;

#pragma mark - Math operations
/**---------------------------------------------------------------------------------------------------------------------
 * @name Algorithmic operations
 *  ---------------------------------------------------------------------------------------
 */

/** Determines the quotient - the integer resulting from decimal division of the numerator and denominator.
 @return An integer as the quotient
 */
- (NSInteger)quotient;

/** Determines the remainder after performing modular division.
 */
- (NSInteger)rational;

/** Performs absolute value on the numerator and the denominator.
 @return Returns this rational.
 */
- (Rational*)abs;

// must be in form @"p/q"
+ (Rational*)parse:(NSString*)numString;

/** Determines the greatest common divisor of the two integers.
 @param u An integer
 @param v Another integer
 @return The greatest common divisor
 */
+ (NSInteger)GCD:(NSInteger)u and:(NSInteger)v;

/** Determines the least common multiple of the two integers.
 @param param1 An integer
 @param param2 Another integer
 @return The least common multiple
 */
+ (NSInteger)LCM:(NSInteger)param1 and:(NSInteger)param2;

/** Determines the greatest common divisor of many integers.
 @params Two or more integers integers
 @return the least common multiple
 */
+ (NSInteger)LCMM:(NSInteger)params, ...;

@end

//// http://stackoverflow.com/a/21371401/629014
//
//#define GET_MACRO(_0, _1, _2, NAME, ...) NAME
//#define FOO(...) GET_MACRO(_0, ##__VA_ARGS__, FOO2, FOO1, FOO0)(__VA_ARGS__)
