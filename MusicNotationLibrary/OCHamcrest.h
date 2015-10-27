//  OCHamcrest by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2014 hamcrest.org. See LICENSE.txt

/**
 @defgroup library Matcher Library

 Library of Matcher implementations.
 */

/**
 @defgroup object_matchers Object Matchers

 Matchers that inspect objects.

 @ingroup library
 */
#import "HCConformsToProtocol.h"
#import "HCHasDescription.h"
#import "HCHasProperty.h"
#import "HCIsEqual.h"
#import "HCIsInstanceOf.h"
#import "HCIsNil.h"
#import "HCIsSame.h"
#import "HCIsTypeOf.h"
#import "HCThrowsException.h"

/**
 @defgroup collection_matchers Collection Matchers

 Matchers of collections.

 @ingroup library
 */
#import "HCEvery.h"
#import "HCHasCount.h"
#import "HCIsCollectionContaining.h"
#import "HCIsCollectionContainingInAnyOrder.h"
#import "HCIsCollectionContainingInOrder.h"
#import "HCIsCollectionOnlyContaining.h"
#import "HCIsDictionaryContaining.h"
#import "HCIsDictionaryContainingEntries.h"
#import "HCIsDictionaryContainingKey.h"
#import "HCIsDictionaryContainingValue.h"
#import "HCIsEmptyCollection.h"
#import "HCIsIn.h"

/**
 @defgroup number_matchers Number Matchers

 Matchers that perform numeric comparisons.

 @ingroup library
 */
#import "HCIsCloseTo.h"
#import "HCOrderingComparison.h"

/**
 @defgroup primitive_number_matchers Primitive Number Matchers

 Matchers for testing equality against primitive numeric types.

 @ingroup number_matchers
 */
#import "HCIsEqualToNumber.h"
#import "HCIsTrueFalse.h"

/**
 @defgroup text_matchers Text Matchers

 Matchers that perform text comparisons.

 @ingroup library
 */
#import "HCIsEqualIgnoringCase.h"
#import "HCIsEqualIgnoringWhiteSpace.h"
#import "HCStringContains.h"
#import "HCStringContainsInOrder.h"
#import "HCStringEndsWith.h"
#import "HCStringStartsWith.h"

/**
 @defgroup logical_matchers Logical Matchers

 Boolean logic using other matchers.

 @ingroup library
 */
#import "HCAllOf.h"
#import "HCAnyOf.h"
#import "HCIsAnything.h"
#import "HCIsNot.h"

/**
 @defgroup decorator_matchers Decorator Matchers

 Matchers that decorate other matchers for better expression.

 @ingroup library
 */
#import "HCDescribedAs.h"
#import "HCIs.h"

/**
 @defgroup integration Unit Test Integration
 */
#import "HCAssertThat.h"
#import "HCTestFailure.h"
#import "HCTestFailureHandler.h"
#import "HCTestFailureHandlerChain.h"

/**
 @defgroup integration_numeric Unit Tests of Primitive Numbers

 Unit test integration for primitive numbers.

 The @c assertThat&lt;Type&gt; macros convert the primitive actual value to an @c NSNumber,
 passing that to the matcher for evaluation. If the matcher is not satisfied, an exception is
 thrown describing the mismatch.

 This family of macros is designed to integrate well with OCUnit and other unit testing
 frameworks. Unmet assertions are reported as test failures. In Xcode, they can be clicked to
 reveal the line of the assertion.

 @ingroup integration
 */
#import "HCNumberAssert.h"

/**
 @defgroup core Core API
 */

/**
 @defgroup helpers Helpers

 Utilities for writing Matchers.

 @ingroup core
 */
