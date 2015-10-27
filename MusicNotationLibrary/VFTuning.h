//
//  VFTuning.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "IAModelBase.h"

@class TuningNames;

//======================================================================================================================
/** The `VFTuning` class implements various types of tunings for tablature.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTuning : IAModelBase

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSArray* tuningValues;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTuningString:(NSString*)tuningString;
+ (TuningNames*)tuningNames;
- (void)setTuning:(NSString*)noteString;
- (NSUInteger)getValueForString:(NSUInteger)stringNum;
- (NSString*)getNoteForFret:(NSUInteger)fretNum andStringNum:(NSUInteger)stringNum;

@end

@interface TuningNames : IAModelBase
{
    NSArray* _standard;
    NSArray* _dagdad;
    NSArray* _dropd;
    NSArray* _eb;
}
@property (strong, nonatomic) NSArray* standard;
@property (strong, nonatomic) NSArray* dagdad;
@property (strong, nonatomic) NSArray* dropd;
@property (strong, nonatomic) NSArray* eb;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end