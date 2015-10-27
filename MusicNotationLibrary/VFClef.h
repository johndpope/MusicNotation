//
//  VFClef.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"

@class Annotation;

//======================================================================================================================
/** The `VFClef` class performs

 The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFClef : VFStaffModifier
{
   @protected
    //    __weak VFStaff *_staff;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) float line;
@property (strong, nonatomic) NSDictionary* clefCodes;
@property (assign, nonatomic) VFClefType type;
@property (assign, nonatomic) NSUInteger startingPitch;
@property (strong, nonatomic) NSString* size;
@property (strong, nonatomic, readonly) NSString* clefName;
@property (strong, nonatomic) Annotation* annotation;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//`````````````````````
//
- (instancetype)initWithType:(VFClefType)clefType;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFClef*)trebleClef;
+ (VFClef*)clefWithType:(VFClefType)type;

+ (VFClef*)clefWithName:(NSString*)clefName;
+ (VFClef*)clefWithName:(NSString*)clefName size:(NSString*)size;
+ (VFClef*)clefWithName:(NSString*)clefName size:(NSString*)size annotationName:(NSString*)annotationName;
+ (VFClef*)clefWithName:(NSString*)clefName size:(NSString*)size annotation:(Annotation*)annotation;

- (void)setCodeAndName;

+ (NSString*)clefNameForType:(VFClefType)clefType;

- (void)addModifierToStaff:(VFStaff*)staff;
- (void)addEndModifierToStaff:(VFStaff*)staff;

@end

@interface Annotation : NSObject
@property (strong, nonatomic) NSString* code;
@property (assign, nonatomic) float point;
@property (assign, nonatomic) float line;
@property (assign, nonatomic) float xShift;
+ (Annotation*)annotationWithCode:(NSString*)code point:(float)point line:(float)line xShift:(float)xShift;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end
