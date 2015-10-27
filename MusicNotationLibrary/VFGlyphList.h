//
//  VFGlyphList.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "IAModelBase.h"
#import "VFEnum.h"

@class VFFloatSize, VFPoint;

//======================================================================================================================
/** The `VFGlyphList` class loads and stores the outline coordinates to draw symbols.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFGlyphList : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property(readonly, copy) NSArray *allObjects;
@property (assign, nonatomic, readonly) NSUInteger numberOfAvailableGlpyhStucts;
@property (strong, nonatomic, readonly) NSArray* availableGlyphStructsArray;
@property (strong, nonatomic, readonly) NSDictionary* availableGlyphStructsDictionary;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
//- (id)nextObject;

+ (instancetype)sharedInstance;

//- (NSUInteger)numberOfAvailableGlpyhs;
//- (NSArray *)availableGlyphsArray;
//- (NSDictionary *)availableGlyphsDictionary;

- (NSArray*)getOutlineForName:(NSString*)name;
- (NSUInteger)indexForName:(NSString*)name;
- (VFFloatSize*)sizeForName:(NSString*)name;
//- (VFPoint*)anchorPointForGlyphNameType:(VFGlyphNameType)type;

@end

@interface VFGlyphStruct : IAModelBase
@property (strong, nonatomic) NSString* stringOutline;
@property (strong, nonatomic) NSArray* arrayOutline;
//@property (strong, nonatomic) NSString *key;
//@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) VFPoint* anchorPoint;
@property (strong, nonatomic) VFFloatSize* size;
@end