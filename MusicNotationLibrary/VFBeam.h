//
//  VFBeam.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"
#import "VFStaffNote.h"

@class VFModifierContext, VFVoice, Rational;

@class BeamConfig;

//======================================================================================================================
/** The `VFBeam` class
 *  creates a new beam from the specified notes. The notes must
 *  be part of the same line, and have the same duration (in ticks).

 The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFBeam : VFModifier

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (assign, nonatomic) NSUInteger ticks;
@property (strong, nonatomic) NSArray* notes;
@property (assign, nonatomic) BOOL unbeamable;
@property (assign, nonatomic) BOOL autoStem;
@property (assign, nonatomic) VFStemDirectionType stemDirection;
@property (assign, nonatomic, getter=getBeamCount) NSUInteger beamCount;
@property (assign, nonatomic) float beamWidth;           // TODO: is this hooked up?
@property (assign, nonatomic) float partialBeamLength;   // TODO: is this hooked up?
//@property (assign, nonatomic) NSUInteger minLine;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNotes:(NSArray*)notes;
- (instancetype)initWithNotes:(NSArray*)notes autoStem:(BOOL)autoStem;
+ (VFBeam*)beamWithNotes:(NSArray*)notes;
+ (VFBeam*)beamWithNotes:(NSArray*)notes autoStem:(BOOL)autoStem;
- (id)breakSecondaryAt:(NSArray*)indices;
- (float)getSlopeYForX:(float)x first_x_px:(float)first_x_px first_y_px:(float)first_y_px slope:(float)slope;
- (void)calculateSlope;
- (void)applyStemExtensions;
- (NSArray*)getBeamLines:(NSString*)duration;
- (void)drawStems:(CGContextRef)ctx;
- (void)drawBeamLines:(CGContextRef)ctx;
//- (void)preFormat;
//- (BOOL)postFormat;
- (void)draw:(CGContextRef)ctx;
+ (VFStemDirectionType)calculateStemDirection:(NSArray*)notes;
+ (NSArray*)getDefaultBeamGroupsForTimeSignatureType:(VFTimeType)timeType;
+ (NSArray*)getDefaultBeamGroupsForTimeSignatureName:(NSString*)timeType;
//+ (NSArray *)applyAndGetBeams:(VFVoice *)voice;
+ (NSArray*)applyAndGetBeams:(VFVoice*)voice;
+ (NSArray*)applyAndGetBeams:(VFVoice*)voice groups:(NSArray*)groups;
+ (NSArray*)applyAndGetBeams:(VFVoice*)voice direction:(VFStemDirectionType)stem_direction groups:(NSArray*)groups;
+ (NSArray*)generateBeams:(NSArray*)notes withDictionary:(NSDictionary*)config;
+ (NSArray*)generateBeams:(NSArray*)notes config:(BeamConfig*)config;

@end

/*!
 * `config` - The configuration object
 *   `groups` - Array of `Fractions` that represent the beat structure to beam the notes
 *   `stem_direction` - Set to apply the same direction to all notes
 *   `beam_rests` - Set to `YES` to include rests in the beams
 *   `beam_middle_only` - Set to `YES` to only beam rests in the middle of the beat
 *   `show_stemlets` - Set to `YES` to draw stemlets for rests
 *   `maintain_stem_directions` - Set to `YES` to not apply new stem
 */
@interface BeamConfig : IAModelBase
@property (strong, nonatomic) NSArray* groups;
@property (assign, nonatomic) VFStemDirectionType stemDirection;
@property (assign, nonatomic) BOOL beamRests;
@property (assign, nonatomic) BOOL beamMiddleOnly;
@property (assign, nonatomic) BOOL showStemlets;
@property (assign, nonatomic) BOOL maintainStemDirections;
@end
