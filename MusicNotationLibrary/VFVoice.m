//
//  VFVoice.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFVoice.h"
#import <objc/runtime.h>
#import "VFVex.h"
#import "VFTickable.h"
#import "Rational.h"
#import "VFStaff.h"
#import "VFVoiceGroup.h"
#import "VFBoundingBox.h"
#import "VFTables.h"
#import "VFEnum.h"
#import "VFDelegates.h"
#import "VFStaffNote.h"
#import "NSString+Ruby.h"
#import "OCTotallyLazy.h"

@implementation VFTime
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}
+ (VFTime*)timeWithBeats:(NSUInteger)numberOfBeats beatValue:(NSUInteger)beatValue resolution:(NSUInteger)resolution;
{
    VFTime* ret = [[VFTime alloc] initWithDictionary:nil];
    ret.numBeats = numberOfBeats;
    ret.beatValue = beatValue;
    ret.resolution = resolution;
    return ret;
}
@end

@interface VFVoice ()
{
    __weak VFStaff* _staff;
    BOOL _preFormatted;
    NSUInteger _largestTickWidth;
    Rational* _ticksUsed;
    Rational* _totalTicks;
    VFTime* _time;
}
@end

@implementation VFVoice

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithTimeDict:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        // TODO: test that passing a time Dict can initialize propertly
        // i.e.
        // init: function(time) {
        //    self.time = Vex.Merge({
        //    num_beats: 4,
        //    beat_value: 4,
        //    resolution: Vex.Flow.RESOLUTION
        //    }, time);

        //        [self setupVoice];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithTime:(VFTime*)timeStruct;
{
    self = [self initWithTimeDict:nil];
    if(self)
    {
        _time = timeStruct;
        [self setupVoice];
    }
    return self;
}

+ (VFVoice*)voiceWithTime:(VFTime*)timeStruct;
{
    return [[VFVoice alloc] initWithTime:timeStruct];
}

+ (VFVoice*)voiceWithBeats:(NSUInteger)numberOfBeats beatValue:(NSUInteger)beatValue resolution:(NSUInteger)resolution
{
    return
        [[VFVoice alloc] initWithTime:[VFTime timeWithBeats:numberOfBeats beatValue:beatValue resolution:resolution]];
}

+ (VFVoice*)voiceWithTimeSignature:(VFTimeType)timeType
{
    if(timeType > 10)
    {
        VFLogError(@"InvalidVFTimeType, argument for VFVoice initializer must be less than 10");
        return nil;
    }
    switch(timeType)
    {
        case VFTime4_4:
            return [VFVoice voiceWithBeats:4 beatValue:4 resolution:kRESOLUTION];
            break;
        case VFTime3_4:
            return [VFVoice voiceWithBeats:3 beatValue:4 resolution:kRESOLUTION];
            break;
        case VFTime2_4:
            return [VFVoice voiceWithBeats:2 beatValue:4 resolution:kRESOLUTION];
            break;
        case VFTime4_2:
            return [VFVoice voiceWithBeats:4 beatValue:2 resolution:kRESOLUTION];
            break;
        case VFTime2_2:
            return [VFVoice voiceWithBeats:2 beatValue:2 resolution:kRESOLUTION];
            break;
        case VFTime3_8:
            return [VFVoice voiceWithBeats:3 beatValue:8 resolution:kRESOLUTION];
            break;
        case VFTime6_8:
            return [VFVoice voiceWithBeats:6 beatValue:8 resolution:kRESOLUTION];
            break;
        case VFTime9_8:
            return [VFVoice voiceWithBeats:9 beatValue:8 resolution:kRESOLUTION];
            break;
        case VFTime12_8:
            return [VFVoice voiceWithBeats:12 beatValue:8 resolution:kRESOLUTION];
            break;
        default:
            return nil;
            break;
    }
}

- (void)setupVoice
{
    // Recalculate total ticks.

    _totalTicks = [Rational rationalWithNumerator:(self.time.numBeats * self.time.resolution / self.time.beatValue)
                                   andDenominator:1];
    _resolutionMultiplier = 1;

    // Set defaults
    _tickables = [NSMutableArray array];
    _ticksUsed = RationalZero();
    self.smallestTickCount = [self.totalTicks clone];
    _largestTickWidth = 0;
    _staff = nil;   //[VFStaff currentStaff];
    _boundingBox = nil;

    // Do we care about strictly timed notes
    _mode = VFModeStrict;

    // This must belong to a VoiceGroup
    _voiceGroup = nil;
}

+ (VFVoice*)voiceWithNumBeats:(NSUInteger)beats beatValue:(NSUInteger)beatValue resolution:(NSUInteger)resolution;
{
    return [VFVoice voiceWithBeats:beats beatValue:beatValue resolution:resolution];
}

+ (VFVoice*)standardVoice
{
    return [VFVoice voiceWithBeats:4 beatValue:4 resolution:kRESOLUTION];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{
        @"num_beats" : @"time.numBeats",
        @"beat_value" : @"time.beatValue",
        @"resolution" : @"time.resolution",
    }];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (VFTime*)time
{
    if(!_time)
    {
        VFLogError(@"InitializationError, no time set for voice, using standard time.");
        _time = [VFTime timeWithBeats:4 beatValue:4 resolution:kRESOLUTION];
    }
    return _time;
}

// Get the actual tick resolution for the voice
- (NSUInteger)getActualResolution
{
    return _resolutionMultiplier * self.time.resolution;
}

- (NSMutableArray*)tickables
{
    if(!_tickables)
    {
        _tickables = [[NSMutableArray alloc] init];
    }
    return _tickables;
}

- (Rational*)totalTicks
{
    if(!_totalTicks)
    {
        _totalTicks = RationalZero();
    }
    return _totalTicks;
}

- (Rational*)ticksUsed
{
    if(!_ticksUsed)
    {
        _ticksUsed = RationalZero();
    }
    return _ticksUsed;
}

- (Rational*)smallestTickCount
{
    if(!_smallestTickCount)
    {
        _smallestTickCount = RationalZero();
    }
    return _smallestTickCount;
}

- (VFStaff*)staff
{
    if(!_staff)
    {
        [VFLog logInfo:[NSString stringWithFormat:@"StaffInstantiationInfo %@", @"no weak staff parent."]];
    }
    return _staff;
}

// set the voice's staff
- (void)setStaff:(VFStaff*)staff
{
    VFLogInfo(@"VoiceStaffSettingInfo, setting up the voice on staff");
    _boundingBox = nil;
    _staff = staff;
}

// Get the bounding box for the voice
- (VFBoundingBox*)boundingBox
{
    _boundingBox = [VFBoundingBox boundingBoxZero];
    if(!self.staff)
    {
        VFLogError(@"NoStaff, Can't get bounding box without Staff.");
    }

    for(VFStaffNote* tickable in self.tickables)
    {
        if([tickable isMemberOfClass:[VFStaffNote class]])
        {
            tickable.staff = self.staff;
            [_boundingBox mergeWithBox:tickable.boundingBox];
        }
        else
        {
            [VFLog logError:@"Unknown object in tickables array."];
        }
    }
    return _boundingBox;
}

// Every tickable must be associated with a voiceGroup. This allows formatters
// and preformatters to associate them with the right modifierContexts.
- (VFVoiceGroup*)getVoiceGroup
{
    if(!_voiceGroup)
    {
        VFLogError(@"NoVoiceGroup, No voice group for voice.");
        return nil;
    }
    return _voiceGroup;
}

// Set the voice mode to strict or soft
// TODO: change this to BOOL?
- (void)setStrict:(VFModeType)mode
{
    if (mode != 0) {
        _mode = mode;
    }
//    _mode = mode  ? VFModeStrict : VFModeSoft;
}

// Determine if the voice is complete according to the voice mode
- (BOOL)isComplete
{
    if(self.mode == VFModeStrict)
    {
        return [self.ticksUsed equalsRational:self.totalTicks];
    }
    else
    {
        return YES;
    }
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

// Add a tickable to the voice
- (id)addTickable:(id<VFTickableDelegate>)tickable
{
    if(![tickable shouldIgnoreTicks])
    {
        Rational* ticks = tickable.ticks;

        // update the total ticks for this line
        [self.ticksUsed add:tickable.ticks];

        if((self.mode == VFModeStrict || self.mode == VFModeFull) && [self.ticksUsed gt:self.totalTicks])
        {
            [self.totalTicks subtract:ticks];
        }

        // track the smallest tickable for formatting
        if([ticks lt:self.smallestTickCount])
        {
            self.smallestTickCount = [ticks clone];
        }
        self.resolutionMultiplier = self.ticksUsed.denominator;

        // expand total ticks using denominator from ticks used
        //[self.totalTicks add:ticks];
        [self.totalTicks add:[Rational rationalWithNumerator:0 andDenominator:self.ticksUsed.denominator]];
    }

    // add the tickable to the line
    [self.tickables addObject:tickable];
    if([tickable isKindOfClass:[VFStaffNote class]])
    {
        tickable.voice = self;
    }
    else
    {
        [VFLog logError:@"NoteAddTickableException, cannot set voice on note."];
    }
    return self;
}

// Add an array of tickables to the voice.
- (id)addTickables:(NSArray*)tickables;
{
    for(id<VFTickableDelegate> tickable in tickables)
    {
        [self addTickable:tickable];
    }
    return self;
}

// Preformats the voice by applying the voice's stave to each note.
- (BOOL)preFormat
{
    if(!_preFormatted)
    {
        [self.tickables foreach:^(id<VFTickableDelegate> tickable, NSUInteger index, BOOL* stop) {
          // NOTE: this differs from original vexflow
          //          if(!tickable.staff)
          //          {
          tickable.staff = self.staff;
          //          }
        }];
    }
    _preFormatted = YES;
    return YES;
}

// Render the voice onto the canvas `context` and an optional `stave`.
// If `stave` is omitted, it is expected that the notes have staves
// already set.
//- (void)draw:(CGContextRef)ctx toStaff:(VFStaff*)staff
- (void)draw:(CGContextRef)ctx dirtyRect:(CGRect)dirtyRect toStaff:(VFStaff*)staff
{
    if(!ctx)
    {
        VFLogError(@"NoCanvasContext, Can't draw without a canvas context.");
    }

    //    VFBoundingBox *boundingBox = ((VFStaffNote *)self.tickables[0]).boundingBox;
    //    for (VFStaffNote *tickable in self.tickables) {
    for(id<VFTickableDelegate> tickable in self.tickables)
    {
        if(staff)
        {
            [tickable setStaff:staff];
        }
        if(!tickable.staff)
        {
            VFLogError(@"MissingStave, The voice cannot draw tickables without staves.");
        }
        //        if (tickable.boundingBox) {
        //            [boundingBox mergeWithBox:tickable.boundingBox];
        //        }

        // TODO: the following call may be unncessesary
        [tickable preFormat];
        [tickable draw:ctx];
    }
    //    self.boundingBox = boundingBox;
}

@end
