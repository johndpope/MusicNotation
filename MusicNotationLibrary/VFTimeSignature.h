//
//  VFTimeSignature.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"
#import "VFEnum.h"
#import "VFOptions.h"

@interface TimeSignatureOptions : Options
@property (assign, nonatomic) float topGlyphCollectionWidth;
@property (assign, nonatomic) float bottomGlyphCollectionWidth;
@end

//======================================================================================================================
/** The `VFTimeSignature` class performs
    Implements time signatures glyphs for staffs
    See tables.js for the internal time signatures
    representation

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTimeSignature : VFStaffModifier
{
   @private
    NSString* _timeSpec;
    VFTimeType _timeType;
    TimeSignatureOptions* _options;
    float _topLine;
    float _bottomLine;
    NSMutableArray* _topGlyphs;
    NSMutableArray* _bottomGlyphs;
    BOOL _num;
    NSArray* _topCodes;
    NSArray* _bottomCodes;
    NSArray* _topNumbers;
    NSArray* _bottomNumbers;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSString* timeSpec;
@property (assign, nonatomic) VFTimeType timeType;
@property (strong, nonatomic) TimeSignatureOptions* options;
//@property (assign, nonatomic) float topLine;
//@property (assign, nonatomic) float bottomLine;
//@property (strong, nonatomic) NSMutableArray* topGlyphs;
//@property (strong, nonatomic) NSMutableArray* bottomGlyphs;
//@property (assign, nonatomic) NSUInteger num;
//@property (strong, nonatomic) NSArray* topCodes;
//@property (strong, nonatomic) NSArray* bottomCodes;
//@property (strong, nonatomic) NSMutableArray* topNumbers;
//@property (strong, nonatomic) NSMutableArray* bottomNumbers;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTimeSpec:(NSString*)timeSpec andPadding:(float)padding;
+ (VFTimeSignature*)timeSignatureWithType:(VFTimeType)type;

@end
