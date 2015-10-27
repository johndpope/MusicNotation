//
//  VFVoice.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFEnum.h"
#import "VFDelegates.h"
#import "IAModelBase.h"

@interface VFTime : NSObject
@property (assign, nonatomic) NSUInteger numBeats;
@property (assign, nonatomic) NSUInteger beatValue;
@property (assign, nonatomic) NSUInteger resolution;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFTime*)timeWithBeats:(NSUInteger)numberOfBeats beatValue:(NSUInteger)beatValue resolution:(NSUInteger)resolution;
@end

@class VFStaff, Rational, VFStaffNote, VFVoiceGroup, VFBoundingBox;

//======================================================================================================================
/** The `VFVoice` class represents a voicing. In music composition and arranging, a voicing is the
        instrumentation and vertical spacing and ordering of the pitches in a chord (which notes are on
        the top or in the middle, which ones are doubled, which octave each is in, and which instruments
        or voices perform each). Which note is on the bottom determines the inversion.

    Voicing is "the manner in which one distributes, or spaces, notes and chords among the various
        instruments" and spacing or "simultaneous vertical placement of notes in relation to each
        other."

     //http://en.wikipedia.org/wiki/Voicing_%28music%29

     The following demonstrates some basic usage of this class.

         VFVoice *voice = [[VFVoice alloc] init];
         voice.numBeats = 4;
         voice.beatValue = 4;

         [voice addTickables:notes];

         VFFormatter *formatter = [[VFFormatter alloc]init];
         [formatter joinVoices:@[voice]];
         [formatter formatWith:@[voice] with:500 andContext:nil];
 */
@interface VFVoice : IAModelBase
{
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) NSMutableArray* tickables;

@property (strong, nonatomic, readonly) Rational* totalTicks;   // Get the total ticks in the voice

@property (strong, nonatomic, readonly)
    Rational* ticksUsed;   // Get the total ticks used in the voice by all the tickables

@property (strong, nonatomic) Rational* smallestTickCount;   // Get the tick count for the shortest tickable

@property (assign, nonatomic, readonly) NSUInteger largestTickWidth;   // Get the largest width of all the tickables

@property (weak, nonatomic) VFStaff* staff;   // Set the voice's stave

@property (strong, nonatomic) VFVoiceGroup* voiceGroup;

@property (retain, nonatomic) VFBoundingBox* boundingBox;

/** strict/soft/full
 */
@property (assign, nonatomic, setter=setStrict:)
    VFModeType mode;   // Get/set the voice mode, use a value from `Voice.Mode`

@property (strong, nonatomic, readonly) VFTime* time;

@property (assign, nonatomic) NSUInteger resolutionMultiplier;   // Get the resolution multiplier for the voice
@property (assign, nonatomic, readonly, getter=getActualResolution) NSUInteger actualResolution;

@property (assign, nonatomic, readonly, getter=isComplete) BOOL isComplete;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithTimeDict:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFVoice*)voiceWithTime:(VFTime*)timeStruct;

+ (VFVoice*)voiceWithNumBeats:(NSUInteger)beats beatValue:(NSUInteger)beatValue resolution:(NSUInteger)resolution;
+ (VFVoice*)voiceWithTimeSignature:(VFTimeType)time;
//- (id)addTickable:(VFStaffNote*)tickable;
- (id)addTickable:(id<VFTickableDelegate>)tickable;
- (id)addTickables:(NSArray*)tickables;

- (BOOL)preFormat;
//- (void)draw:(CGContextRef)ctx toStaff:(VFStaff*)staff;
- (void)draw:(CGContextRef)ctx dirtyRect:(CGRect)dirtyRect toStaff:(VFStaff*)staff;

@end
