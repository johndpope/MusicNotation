//
//  VFFormatter.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

#import "VFFormatter.h"
#import "VFVex.h"
#import "VFEnum.h"
#import "Rational.h"
#import "VFMetrics.h"
#import "VFModifierContext.h"
#import "VFTickContext.h"
#import "VFStaff.h"
#import "VFVoice.h"
#import "VFTabStaff.h"
#import "VFTextNote.h"
#import "VFVex.h"
#import "VFVoice.h"
#import "VFBeam.h"
#import "VFOptions.h"
#import "VFStaffNote.h"
#import "VFGlyph.h"
#import "VFTickable.h"
#import "VFContextDelegate.h"
#import "NSString+Ruby.h"
#import "OCTotallyLazy.h"
#import "VFTickable.h"
#import "VFStaffConnector.h"
#import "VFKeyProperty.h"
#import "VFDelegates.h"
#import "NSMutableArray+JSAdditions.h"

@implementation Context
- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

@end

typedef void (^AddFunction)(VFTickable*, id);

@interface VFFormatter (private)
//@property (strong, nonatomic) Context *tContexts;
//@property (strong, nonatomic) Context *mContexts;
//@property (assign, nonatomic) float minTotalWidth;
//@property (assign, nonatomic) BOOL hasMinTotalWidth;
//@property (strong, nonatomic) Rational *totalTicks;
@end

@implementation VFFormatter

+ (VFFormatter*)formatter;
{
    return [[VFFormatter alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupFormatter];
    }
    return self;
}

- (void)setupFormatter
{
    // Minimum width required to render all the notes in the voices.
    _minTotalWidth = 0;

    // self is set to `YES` after `minTotalWidth` is calculated.
    _hasMinTotalWidth = NO;

    // The suggested amount of space for each tick.
    _pixelsPerTick = 0;

    // Total number of ticks in the voice.
    _totalTicks = RationalZero();

    // Arrays of tick and modifier contexts.
    //    self.tContexts = nil;
    //    self.mContexts = nil;
}

//======================================================================================================================
// PRIVATE Methods

// private
/*!
 *  Helper function to locate the next non-rest note(s).
 *  @param notes          <#notes description#>
 *  @param restLine       <#restLine description#>
 *  @param lookAheadIndex <#lookAheadIndex description#>
 *  @param shouldCompare  <#shouldCompare description#>
 *  @return <#return value description#>
 */
+ (NSUInteger)lookAhead:(NSArray*)notes
            andRestLine:(NSUInteger)restLine
                     by:(NSUInteger)lookAheadIndex
        makeComparisons:(BOOL)shouldCompare;
{
    // If no valid next note group, next_rest_line is same as current.
    NSUInteger next_rest_line = restLine;
    NSUInteger i = lookAheadIndex;
    ++i;
    while(i < notes.count)
    {
        if(!((VFStaffNote*)notes[i]).isRest && !((VFStaffNote*)notes[i]).shouldIgnoreTicks)
        {
            next_rest_line = [((VFStaffNote*)notes[i])getLineForRest];
            break;
        }
        i++;
    }

    // Locate the mid point between two lines.
    if(shouldCompare && restLine != next_rest_line)
    {
        NSUInteger top = MAX(restLine, next_rest_line);
        NSUInteger bot = MIN(restLine, next_rest_line);
        next_rest_line = vfmidline(top, bot);
    }

    return next_rest_line;
}

// private
/*!
 *  Take an array of `voices` and place aligned tickables in the same context. Returns
 *  a mapping from `tick` to `context_type`, a list of `tick`s, and the resolution
 *  multiplier.
 *  @param voices      Array of `Voice` instances.
 *  @param contextType A context class (e.g., `ModifierContext`, `TickContext`)
 *  @param add_fn      Function to add tickable to context.
 *  @return <#return value description#>
 */
- (Context*)createContexts:(NSArray*)voices withContextType:(Class)contextType andAddFunction:(AddFunction)add_fn;
{
    if(!voices || voices.count == 0)
    {
        VFLogError(@"BadArgument, No voices to format");
    }

    // Initialize tick maps.
    Rational* totalTicks = [((VFVoice*)voices[0])totalTicks];
    NSMutableDictionary* tickToContextMap = [NSMutableDictionary dictionary];
    NSMutableArray* tickList = [NSMutableArray array];
    NSMutableArray* contexts = [NSMutableArray array];

    NSUInteger resolutionMultiplier = 1;

    // Find out highest common multiple of resolution multipliers.
    // The purpose of self is to find out a common denominator
    // for all fractional tick values in all tickables of all voices,
    // so that the values can be expanded and the numerator used
    // as an integer tick value.
    NSUInteger i;   // shared iterator
    VFVoice* voice = nil;
    for(i = 0; i < voices.count; ++i)
    {
        voice = (VFVoice*)voices[i];
        if(!([voice.totalTicks equalsRational:totalTicks]))
        {
            VFLogError(@"TickMismatch, Voices should have same total note duration in ticks.");
        }

        if(voice.mode == VFModeStrict && !voice.isComplete)
        {
            VFLogError(@"IncompleteVoice, Voice does not have enough notes.");
        }

        NSUInteger lcm = [Rational LCM:resolutionMultiplier and:voice.resolutionMultiplier];
        if(resolutionMultiplier < lcm)
        {
            resolutionMultiplier = lcm;
        }
    }

    // For each voice, extract notes and create a context for every
    // new tick that hasn't been seen before.
    for(i = 0; i < voices.count; ++i)
    {
        voice = voices[i];

        NSArray* tickables = voice.tickables;

        // Use resolution multiplier as denominator to expand ticks
        // to suitable integer values, so that no additional expansion
        // of fractional tick values is needed.
        Rational* ticksUsed = [Rational rationalWithNumerator:0 andDenominator:resolutionMultiplier];

        for(NSUInteger j = 0; j < tickables.count; ++j)
        {
            id<VFTickableDelegate> tickable = tickables[j];
            NSUInteger integerTicks = ticksUsed.numerator;   // unsignedIntegerValue];

            // If we have no tick context for self tick, create one.
            NSNumber* numIntegerTicks = [NSNumber numberWithUnsignedInteger:integerTicks];
            if(!tickToContextMap[numIntegerTicks])
            {
                id newContext = [[contextType alloc] init];
                [contexts push:newContext];
                tickToContextMap[numIntegerTicks] = newContext;
            }

            // Add self tickable to the TickContext.
            add_fn(tickable, tickToContextMap[numIntegerTicks]);

            // Maintain a sorted list of tick contexts.
            [tickList push:numIntegerTicks];   //.push(integerTicks);
            [ticksUsed add:tickable.ticks];    // .add(tickable.getTicks());
        }
    }

    Context* ret = [[Context alloc] init];
    ret.map = tickToContextMap;
    ret.array = contexts;
    ret.list = [[VFVex sortAndUnique:tickList
        withCmp:^NSComparisonResult(NSNumber* obj1, NSNumber* obj2) {
          NSUInteger a = [obj1 unsignedIntegerValue];
          NSUInteger b = [obj2 unsignedIntegerValue];
          if(a < b)
          {
              return (NSComparisonResult)NSOrderedAscending;
          }
          else if(a > b)
          {
              return (NSComparisonResult)NSOrderedDescending;
          }
          else
          {
              return (NSComparisonResult)NSOrderedSame;
          }
        }
        andEq:^BOOL(NSNumber* obj1, NSNumber* obj2) {
          return [obj1 unsignedIntegerValue] == [obj2 unsignedIntegerValue];
        }] mutableCopy];
    ret.resolutionMultiplier = resolutionMultiplier;
    return ret;
}

//======================================================================================================================
// STATIC Methods

/*!
 *  Helper function to format and draw a single voice. Returns a bounding
 *  box for the notation.
 *  @param ctx    The rendering context
 *  @param staff  The staff to which to draw (`staff` or `Tabstaff`)
 *  @param notes  Array of `Note` instances (`staffNote`, `TextNote`, `TabNote`, etc.)
 *  @param params One of below:
 *                  Setting `autobeam` only `(context, staff, notes, YES)` or `(ctx, staff, notes, {autobeam: YES})`
 *                  Setting `align_rests` a struct is needed `(context, staff, notes, {align_rests: YES})`
 *                  Setting both a struct is needed `(context, staff, notes, {autobeam: YES, align_rests: YES})`
 *                      `autobeam` automatically generates beams for the notes.
 *                      `align_rests` aligns rests with nearby notes.
 *
 *  @return a bounding box
 */
+ (VFBoundingBox*)formatAndDrawWithContext:(CGContextRef)ctx
                                 dirtyRect:(CGRect)dirtyRect
                                   toStaff:(VFStaff*)staff
                                 withNotes:(NSArray*)notes
                                withParams:(NSDictionary*)params;
{
    
    NSDictionary* options = [NSMutableDictionary merge:@{@"auto_beam" : @NO, @"align_rests" : @NO} with:params];

    // Start by creating a voice and adding all the notes to it.
    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    voice.mode = VFModeSoft;      // setMode(Vex.Flow.Voice.Mode.SOFT);
    [voice addTickables:notes];   // voice.addTickables(notes);

    // Then create beams, if requested.
    NSArray* beams = nil;
    if([options[@"auto_beam"] boolValue])
    {
        //        beams = [VFBeam applyAndGetBeams:voice];
        // TODO: test this
        beams = [VFBeam applyAndGetBeams:voice direction:VFStemDirectionNone groups:nil];
    }

    // Instantiate a `Formatter` and format the notes.
    VFFormatter* formatter = [[VFFormatter alloc] init];
    [formatter joinVoices:@[ voice ] params:@{@"align_rests" : options[@"align_rests"]}];
    [formatter formatToStaff:@[ voice ] staff:staff options:@{@"align_rests" : options[@"align_rests"]}];

    // Render the voice and beams to the staff.
    [voice setStaff:staff];
    [voice draw:ctx dirtyRect:dirtyRect toStaff:staff];
    if(beams != nil)
    {
        for(int i = 0; i < beams.count; ++i)
        {
            [((VFBeam*)beams[i])draw:ctx];
        }
    }

    // Return the bounding box of the voice.
    return voice.boundingBox;
}
+ (VFBoundingBox*)formatAndDrawWithContext:(CGContextRef)ctx
                                   toStaff:(VFStaff*)staff
                                 withNotes:(NSArray*)notes
                          withJustifyWidth:(float)justifyWidth;
{
    [VFLog logNotYetImplementedForClass:[self class] andSelector:_cmd];
    return nil;
}

+ (VFBoundingBox*)formatAndDrawWithContext:(CGContextRef)ctx
                                 dirtyRect:(CGRect)dirtyRect
                                   toStaff:(VFStaff*)staff
                                 withNotes:(NSArray*)notes;
{
    return [VFFormatter formatAndDrawWithContext:ctx dirtyRect:dirtyRect toStaff:staff withNotes:notes withParams:nil];
}

/*!
 *  Helper function to format and draw aligned tab and staff notes in two
 *  separate staffs.
 *
 *  @param ctx      The rendering context
 *  @param staff    A `Tabstaff` instance on which to render `TabNote`s.
 *  @param tabStaff A `staff` instance on which to render `Note`s.
 *  @param tabNotes Array of `TabNote` instances for the tab staff (`TabNote`, `BarNote`, etc.)
 *  @param notes    Array of `Note` instances for the staff (`staffNote`, `BarNote`, etc.)
 *  @param autobeam Automatically generate beams.
 *  @param params   A configuration object:
 *                      `autobeam` automatically generates beams for the notes.
 *                      `align_rests` aligns rests with nearby notes.
 *  @return YES if successful
 */
+ (BOOL)formatAndDrawTabWithContext:(CGContextRef)ctx
                          dirtyRect:(CGRect)dirtyRect
                       withTabStaff:(VFTabStaff*)staff
                       withTabStaff:(VFTabStaff*)tabStaff
                        andTabNotes:(NSArray*)tabNotes
                           andNotes:(NSArray*)notes
                            andBeam:(BOOL)autobeam
                         withParams:(NSDictionary*)params;
{
    NSDictionary* opts = @{@"auto_beam" : @(autobeam), @"align_rests" : @NO};

    opts = [NSMutableDictionary merge:opts with:params];

    // Create a `4/4` voice for `notes`.
    VFVoice* notevoice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    notevoice.mode = VFModeSoft;
    [notevoice addTickables:notes];

    // Create a `4/4` voice for `tabnotes`.
    VFVoice* tabvoice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    tabvoice.mode = VFModeSoft;
    [tabvoice addTickables:tabNotes];

    // Generate beams if requested.
    NSArray* beams = nil;
    if([opts[@"auto_beam"] boolValue])
    {
        //        beams = [VFBeam applyAndGetBeams:notevoice];
        // TODO: test this
        beams = [VFBeam applyAndGetBeams:notevoice direction:VFStemDirectionNone groups:nil];
    }

    // Instantiate a `Formatter` and align tab and staff notes.
    VFFormatter* formatter = [[VFFormatter alloc] init];
    [formatter joinVoices:@[ notevoice ] params:@{@"align_rests" : opts[@"align_rests"]}];
    [formatter joinVoices:@[ tabvoice ]];
    [formatter formatToStaff:@[ notevoice, tabvoice ] staff:staff options:@{@"align_rests" : opts[@"align_rests"]}];

    // Render voices and beams to staffs.
    [notevoice draw:ctx dirtyRect:dirtyRect toStaff:staff];
    [tabvoice draw:ctx dirtyRect:dirtyRect toStaff:tabStaff];
    if(beams != nil)
    {
        for(NSUInteger i = 0; i < beams.count; ++i)
        {
            [((VFBeam*)beams[i])draw:ctx];
        }
    }

    // Draw a connector between tab and note staffs.
    VFStaffConnector* connector = [[VFStaffConnector alloc] initWithTopStaff:staff andBottomStaff:tabStaff];
    [connector draw:ctx];
    return YES;
}

/*!
 *  Auto position rests based on previous/next note positions.
 *  @param notes         An array of notes.
 *  @param alignAllNotes If set to NO, only aligns non-beamed notes.
 *  @param alignTuplets  If set to NO, ignores tuplets.
 */
+ (void)alignRestsToNotes:(NSArray*)notes withNoteAlignment:(BOOL)alignAllNotes andTupletAlignment:(BOOL)alignTuplets;
{
    for(NSUInteger i = 0; i < notes.count; ++i)
    {
        if([notes[i] isKindOfClass:[VFStaffNote class]] && ((VFStaffNote*)notes[i]).isRest)
        {
            VFStaffNote* note = notes[i];

            if(note.tuplet && !alignTuplets)
            {
                continue;
            }

            // If activated rests not on default can be rendered as specified.
            NSString* position = note.glyphStruct.position.uppercaseString;   // note.getGlyph().position.toUpperCase();
            if([position isNotEqualToString:@"R/4"] && [position isNotEqualToString:@"B/4"])
            {
                continue;
            }

            if(alignAllNotes || note.beam != nil)
            {
                // Align rests with previous/next notes.
                KeyProperty* props = note.keyProps[0];
                if(i == 0)
                {
                    props.line = [self lookAhead:notes andRestLine:props.line by:i makeComparisons:NO];
                    [note setKeyLine:0 withLine:props.line];   // .setKeyLine(0, props.line);
                }
                else if(i > 0 && i < notes.count)
                {
                    // If previous note is a rest, use its line number.
                    NSUInteger rest_line;
                    if(((VFStaffNote*)notes[i - 1]).isRest)
                    {
                        rest_line = ((KeyProperty*)((VFStaffNote*)notes[i - 1]).keyProps[0]).line;
                        props.line = rest_line;
                    }
                    else
                    {
                        rest_line = [((VFStaffNote*)notes[i - 1])getLineForRest];
                        // Get the rest line for next valid non-rest note group.
                        props.line = [self lookAhead:notes andRestLine:rest_line by:i makeComparisons:YES];
                    }
                    [note setKeyLine:0 withLine:props.line];
                }
            }
        }
    }
}

/*!
 *  Find all the rests in each of the `voices` and align them
 *  to neighboring notes. If `align_all_notes` is `NO`, then only
 *  align non-beamed notes.

 *  @param voices        the collection of voices
 *  @param alignAllNotes <#alignAllNotes description#>
 */
- (void)alignRests:(NSArray*)voices alignAllNotes:(BOOL)alignAllNotes;
{
    /*
    // ## Prototype Methods
    Formatter.prototype = @{

    alignRests: function(voices, align_all_notes) {
        if (!voices || !voices.count) [VFLog LogError:@"BadArgument",
                                                          "No voices to format rests");
        for (var i = 0; i < voices.count; i++) {
            new Formatter.AlignRestsToNotes(voices[i].tickables, align_all_notes);
        }
    },
     */
    if(!voices || voices.count == 0)
    {
        VFLogError(@"BadArgument, No voices to format rests");
    }
    for(NSUInteger i = 0; i < voices.count; ++i)
    {
        [VFFormatter alignRestsToNotes:((VFVoice*)voices[i]).tickables
                     withNoteAlignment:alignAllNotes
                    andTupletAlignment:NO];
    }
}

/*!
 *  Calculate the minimum width required to align and format `voices`.
 *  @param voices the collection of voices
 *  @return <#return value description#>
 */
- (float)preCalculateMinTotalWidth:(NSArray*)voices;
{
    // Cache results.
    if(self.hasMinTotalWidth)
    {
        return self.minTotalWidth;
    }

    // Create tick contexts if not already created.
    if(!self.tContexts)
    {
        if(!voices)
        {
            VFLogError(@"BadArgument, 'voices' required to run preCalculateMinTotalWidth");
        }
        [self createTickContexts:voices];
    }

    Context* contexts = self.tContexts;
    NSArray* contextList = contexts.list;
    NSDictionary* contextMap = contexts.map;

    self.minTotalWidth = 0;

    // Go through each tick context and calculate total width.
    for(NSUInteger i = 0; i < contextList.count; ++i)
    {
        id<VFContextDelegate> context = contextMap[contextList[i]];

        // `preFormat` gets them to descend down to their tickables and modifier
        // contexts, and calculate their widths.
        [context preFormat];
        self.minTotalWidth += context.width;
    }

    self.hasMinTotalWidth = YES;

    return self.minTotalWidth;
}

/*!
 *  Get minimum width required to render all voices. Either `format` or
 *  `preCalculateMinTotalWidth` must be called before self method.
 *  @return <#return value description#>
 */
- (float)getMinTotalWidth;
{
    /*
    getMinTotalWidth: function() {
        if (!self.hasMinTotalWidth) {
            [VFLog LogError:@"NoMinTotalWidth",
                               "Need to call 'preCalculateMinTotalWidth' or 'preFormat' before" +
                               " calling 'getMinTotalWidth'");
        }

        return self.minTotalWidth;
    },

     */
    if(!self.hasMinTotalWidth)
    {
        VFLogError(@"NoMinTotalWidth, Need to call 'preCalculateMinTotalWidth' or 'preFormat' before calling "
                   @"'getMinTotalWidth'");
    }

    return self.minTotalWidth;
}

/*!
 *  Create `ModifierContext`s for each tick in `voices`.
 *  @param voices the collection of voices
 *  @return <#return value description#>
 */
- (Context*)createModifierContexts:(NSArray*)voices;
{
    /*
    createModifierContexts: function(voices) {
        var contexts = createContexts(voices,
                                      Vex.Flow.ModifierContext,
                                      function(tickable, context) {
                                          tickable.addToModifierContext(context);
                                      });
        self.mContexts = contexts;
        return contexts;
    },

     */
    Context* contexts = [self createContexts:voices
                             withContextType:[VFModifierContext class]
                              andAddFunction:^(VFTickable* tickable, VFModifierContext* context) {
                                [tickable addToModifierContext:context];
                              }];
    self.mContexts = contexts;
    return contexts;
}

/*!
 *  Create `TickContext`s for each tick in `voices`. Also calculate the
 *  total number of ticks in voices.
 *
 *  @param voices the collection of voices
 *  @return <#return value description#>
 */
- (Context*)createTickContexts:(NSArray*)voices;
{
    /*
    createTickContexts: function(voices) {
        var contexts = createContexts(voices,
                                      Vex.Flow.TickContext,
                                      function(tickable, context) { context.addTickable(tickable); });

        contexts.array.forEach(function(context) {
            context.tContexts = contexts.array;
        });

        self.totalTicks = voices[0].getTicksUsed().clone();
        self.tContexts = contexts;
        return contexts;
    },
     */
    Context* contexts = [self createContexts:voices
                             withContextType:[VFTickContext class]
                              andAddFunction:^(VFTickable* tickable, VFTickContext* context) {
                                [context addTickable:tickable];
                              }];
    [contexts.array foreach:^(VFTickContext* context, NSUInteger index, BOOL* stop) {
      context.tContexts = contexts.array;
    }];
    self.totalTicks = [((VFVoice*)[voices firstObject]).ticksUsed clone];
    self.tContexts = contexts;
    return contexts;
}

/*!
 *  this is the core formatter logic. Format voices and justify them
 *  to `justifyWidth` pixels. `graphicsContext` is required to justify elements
 *  that can't retreive widths without a canvas. self method sets the `x` positions
 *  of all the tickables/notes in the formatter.
 *
 *  @param voices the collection of voices
 *  @param staff  the staff being drawn onto
 *  @return YES if successful
 */
- (BOOL)preFormatWithContext:(CGContextRef)ctx voices:(NSArray*)voices staff:(VFStaff*)staff;
{
    return [self preFormatWith:0 voices:voices staff:staff];
}
- (BOOL)preFormat
{
    return [self preFormatWith:0 voices:@[] staff:nil];
}
- (BOOL)preFormatWith:(float)justifyWidth voices:(NSArray*)voices staff:(VFStaff*)staff;
{
    // Initialize context maps.
    Context* contexts = self.tContexts;
    NSArray* contextList = contexts.list;
    NSDictionary* contextMap = contexts.map;

    // If voices and a staff were provided, set the staff for each voice
    // and preFormat to apply Y values to the notes;
    if(voices && staff)
    {
        [voices foreach:^(VFVoice* voice, NSUInteger index, BOOL* stop) {
          [voice setStaff:staff];
          [voice preFormat];
        }];
    }

    // Figure out how many pixels to allocate per tick.
    if(justifyWidth == 0)
    {
        self.pixelsPerTick = 0;
    }
    else
    {
        self.pixelsPerTick = justifyWidth / (self.totalTicks.floatValue * contexts.resolutionMultiplier);
    }

    // Now distribute the ticks to each tick context, and assign them their
    // own X positions.
    float x = 0;
    float center_x = justifyWidth / 2;
    float white_space = 0;   // White space to right of previous note
    float tick_space = 0;    // Pixels from prev note x-pos to curent note x-pos
    NSNumber* prev_tick = nil;
    float prev_tick_value = 0; //NSUInteger prev_tick_value = 0;
    float prev_width = 0;
    id<TickableMetrics> lastMetrics = nil;
    float initial_justify_width = justifyWidth;
    self.minTotalWidth = 0;

    NSNumber* tick;
    float tickValue; //NSUInteger tickValue;
    id<VFContextDelegate> context;

    // Pass 1: Give each note maximum width requested by context.
    for(NSUInteger i = 0; i < contextList.count; ++i)
    {
        tick = contextList[i];
        tickValue = tick.floatValue;
        context = contextMap[tick];

        // Make sure that all tickables in self context have calculated their
        // space requirements.
        [context preFormat];

        id<TickableMetrics> selfMetrics = context.metrics;   // .getMetrics();
        float width = context.width;
        self.minTotalWidth += width;
        float min_x = 0;
        float pixels_used = width;

        // Calculate space between last note and next note.
        tick_space = MIN((tickValue - prev_tick_value) * self.pixelsPerTick, pixels_used);

        // Shift next note up `tick_space` pixels.
        float set_x = x + tick_space;

        // Calculate the minimum next note position to allow for right modifiers.
        if(lastMetrics != nil)
        {
            min_x = x + prev_width - lastMetrics.extraLeftPx;
        }

        // Determine the space required for the previous tick.
        // The `shouldIgnoreTicks` bool is YES for elements in the staff
        // that don't consume ticks (bar lines, key and time signatures, etc.)
        set_x = context.shouldIgnoreTicks ? (min_x + context.width) : vfmax(set_x, min_x);

        if([context shouldIgnoreTicks] && justifyWidth)
        {
            // self note stole room... recalculate with new justification width.
            justifyWidth -= context.width;
            self.pixelsPerTick = justifyWidth / (self.totalTicks.floatValue * contexts.resolutionMultiplier);
        }

        // Determine pixels needed for left modifiers.
        float left_px = selfMetrics.extraLeftPx;

        // Determine white space to right of previous tick (from right modifiers.)
        if(lastMetrics != nil)
        {
            white_space = (set_x - x) - (prev_width - lastMetrics.extraLeftPx);
        }

        // Deduct pixels from white space quota.
        if(i > 0)
        {
            if(white_space > 0)
            {
                if(white_space >= left_px)
                {
                    // Have enough white space for left modifiers - no offset needed.
                    left_px = 0;
                }
                else
                {
                    // Decrease left modifier offset by amount of white space.
                    left_px -= white_space;
                }
            }
        }

        // Adjust the tick x position with the left modifier offset.
        set_x += left_px;

        // Set the `x` value for the context, which sets the `x` value for all
        // tickables in self context.
        context.x = set_x;                  //.setX(set_x);
        context.pixelsUsed = pixels_used;   //.setPixelsUsed(pixels_used);  // ??? Remove self if nothing breaks

        lastMetrics = selfMetrics;
        prev_width = width;
        prev_tick = tick;
        x = set_x;
    }

    self.hasMinTotalWidth = YES;
    if(justifyWidth > 0)
    {
        // Pass 2: Take leftover width, and distribute it to proportionately to
        // all notes.
        float remaining_x = initial_justify_width - (x + prev_width);
        float leftover_pixels_per_tick = remaining_x / (self.totalTicks.floatValue * contexts.resolutionMultiplier);
        float accumulated_space = 0;
        prev_tick_value = 0;

        for(NSUInteger i = 0; i < contextList.count; ++i)
        {
            tick = contextList[i];
            tickValue = tick.floatValue;
            context = contextMap[tick];
            tick_space = (tickValue - prev_tick_value) * leftover_pixels_per_tick;
            accumulated_space = accumulated_space + tick_space;
            context.x = (context.x + accumulated_space);
            prev_tick = tick;
            prev_tick_value = tickValue;

            // Move center aligned tickables to middle
            NSArray* centeredTickables = [context getCenterAlignedTickables];   //.getCenterAlignedTickables();

            [centeredTickables foreach:^(VFTickable* tickable, NSUInteger index, BOOL* stop) {
              tickable.centerXShift = center_x - context.x;
            }];
        }
    }
    return YES;
}

/*!
 *  self is the top-level call for all formatting logic completed
 *  after `x` *and* `y` values have been computed for the notes
 *  in the voices.
 *
 *  @param voices the collection of voices
 *  @return <#return value description#>
 */
- (BOOL)postFormat   //:(NSArray*)voices;
{
    // Postformat modifier contexts
    [self.mContexts.list foreach:^(NSNumber* mContext, NSUInteger index, BOOL* stop) {
      [self.mContexts.map[mContext] postFormat];
    }];

    // Postformat tick contexts
    [self.tContexts.list foreach:^(NSNumber* mContext, NSUInteger index, BOOL* stop) {
      [self.tContexts.map[mContext] postFormat];
    }];
    return YES;
}

- (id)joinVoices:(NSArray*)voices;
{
    [self joinVoices:voices params:nil];
    return self;
}

/*!
 *  Take all `voices` and create `ModifierContext`s out of them. self tells
 *  the formatters that the voices belong on a single staff.
 *
 *  @param voices the collection of voices
 *  @param params <#params description#>
 */
- (void)joinVoices:(NSArray*)voices params:(NSDictionary*)params;
{
    [self createModifierContexts:voices];
    self.hasMinTotalWidth = NO;
}

- (id)formatWith:(NSArray*)voices;
{
    [self formatWith:voices withJustifyWidth:0];
    return self;
}

- (id)formatWith:(NSArray*)voices withJustifyWidth:(float)justifyWidth;
{
    return [self formatWith:voices withJustifyWidth:justifyWidth andOptions:@{}];
}

/*!
 *  Align rests in voices, justify the contexts, and position the notes
 *  so voices are aligned and ready to render onto the staff. self method
 *  mutates the `x` positions of all tickables in `voices`.
 *
 *  Voices are full justified to fit in `justifyWidth` pixels.
 *
 *  Set `options.context` to the rendering context. Set `options.align_rests`
 *  to YES to enable rest alignment.
 *
 *  @param voices       the collection of voices
 *  @param justifyWidth the width to fit the notes into
 *  @param options      <#options description#>
 *  @return this formatter object
 */
- (id)formatWith:(NSArray*)voices withJustifyWidth:(float)justifyWidth andOptions:(NSDictionary*)options;
{
    NSDictionary* opts = @{@"align_rests" : @(NO), @"context" : [NSNull null]};
    opts = [NSMutableDictionary merge:opts with:options];
    [self alignRests:voices alignAllNotes:[opts[@"align_rests"] boolValue]];
    [self createTickContexts:voices];

    VFStaff* staff = opts[@"staff"];

    [self preFormatWith:justifyWidth voices:voices staff:staff];

    if([opts.allKeys containsObject:@"staff"] && opts[@"staff"] != [NSNull null])
    {
        [self postFormat];
    }
    return self;
}

- (id)formatToStaff:(NSArray*)voices staff:(VFStaff*)staff;
{
    return [self formatToStaff:voices staff:staff options:nil];
}

/*!
 *  this method is just like `format` except that the `justifyWidth` is inferred
 *  from the `staff`.
 *  @param voices  the collection of voices
 *  @param staff   <#staff description#>
 *  @param options the collection of voices
 *  @return <#return value description#>
 */
- (id)formatToStaff:(NSArray*)voices staff:(VFStaff*)staff options:(NSDictionary*)options;
{
    // TODO: this could be one spot to reduce width from clefs, time sigs, etc.
    float justifyWidth = staff.noteEndX - staff.noteStartX - 10;
    VFLogInfo(@"Formatting voices to width: %f", justifyWidth);
    //    NSDictionary* opts = @{@"context" : [NSValue valueWithPointer:staff.graphicsContext]};
    NSDictionary* params = [NSMutableDictionary merge:options with:@{@"staff" : staff}];
    return [self formatWith:voices withJustifyWidth:justifyWidth andOptions:params];
}

- (void)draw:(CGContextRef)ctx;
{
    [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:nil withNotes:nil];
}

@end
