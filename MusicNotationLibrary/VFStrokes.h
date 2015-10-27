//
//  VFStrokes.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"
#import "VFEnum.h"

@class VFNote;

//======================================================================================================================
/** The `VFStrokes` class implements chord strokes - arpeggiated, brush & rasquedo.

 The following demonstrates some basic usage of this class.

     ExampleCode...
 */
@interface VFStroke : VFModifier
{
   @private
    __weak VFNote* _noteEnd;
    VFPositionType _position;
    VFStrokeType _type;
    //    NSInteger _index;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) VFStrokeType type;
@property (assign, nonatomic) BOOL allVoices;
@property (weak, nonatomic) VFNote* noteEnd;
@property (assign, nonatomic) VFPositionType position;
@property (assign, nonatomic) float xShift;
//@property (assign, nonatomic) NSUInteger index;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFStroke*)strokeWithType:(VFStrokeType)type;
+ (VFStroke*)strokeWithType:(VFStrokeType)type allVoices:(BOOL)allVoices;
//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;
- (id)addEndNote:(VFNote*)note;

@end
