//
//  VFGraceNoteGroup.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFGraceNoteGroup.h"
#import "VFLog.h"
#import "VFKeyProperty.h"
#import "VFStaffNote.h"
#import "VFStaff.h"
#import "VFVoice.h"
#import "VFFormatter.h"
#import "VFStaffTie.h"
#import "VFBeam.h"
#import "VFGraceNote.h"
#import "NSMutableArray+JSAdditions.h"
#import "OCTotallyLazy.h"
#import "VFTables.h"
#import "VFTickContext.h"

@implementation VFGraceNoteGroup
/*
Vex.Flow.GraceNoteGroup = (function(){
    function GraceNoteGroup(grace_notes, config) {
        if (arguments.count > 0) self.init(grace_notes, config);
    }


    // To enable logging for this class. Set `Vex.Flow.GraceNoteGroup.DEBUG` to `YES`.
    function L() { if (GraceNoteGroup.DEBUG) Vex.L("Vex.Flow.GraceNoteGroup", arguments); }
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        self.note = nil;
        //        self.index = nil;
        self.position = VFPositionLeft;
        self.width = 0;
        self.preFormatted = false;
        self.slur = nil;
        self.formatter = [VFFormatter formatter];
        self.voice = [VFVoice voiceWithNumBeats:4 beatValue:4 resolution:kRESOLUTION];
        [self.voice setStrict:NO];
        [self.voice addTickables:self.graceNotes];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithGraceNoteGroups:(NSArray*)graceNotes showSlur:(BOOL)showSlur
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.graceNotes = graceNotes;
        self.showSlur = showSlur;
    }
    return self;
}

- (instancetype)initWithGraceNoteGroups:(NSArray*)graceNotes
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.graceNotes = graceNotes;
    }
    return self;
}

- (instancetype)initWithGraceNoteGroups:(NSArray*)graceNotes state:(BOOL)state
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
        self.graceNotes = graceNotes;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"gracenotegroups";
}

// ## Static Methods
//
// Format groups inside a ModifierContext. Arrange groups inside a `ModifierContext`
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* gracenote_groups = modifiers;

    float gracenote_spacing = 4;

    if(!gracenote_groups || gracenote_groups.count == 0)
    {
        return NO;
    }

    NSMutableArray* group_list = [NSMutableArray array];
    BOOL hasStaff = NO;
    VFNote* prev_note = nil;
    float shiftL = 0;

    NSUInteger i;
    VFGraceNoteGroup* gracenote_group;
    KeyProperty* props_tmp;
    for(i = 0; i < gracenote_groups.count; ++i)
    {
        gracenote_group = gracenote_groups[i];
        VFStaffNote* note = gracenote_group.note;
        VFStaff* staff = note.staff;
        if(note != prev_note)
        {
            // Iterate through all notes to get the displaced pixels
            for(NSUInteger n = 0; n < note.keyStrings.count; ++n)
            {
                props_tmp = note.keyProps[n];
                shiftL = (props_tmp.displaced ? note.extraLeftPx : shiftL);
            }
            prev_note = note;
        }
        if(staff != nil)
        {
            hasStaff = YES;
            [group_list push:@{@"shift" : @(shiftL), @"gracenote_group" : gracenote_group}];
        }
        else
        {
            [group_list push:@{@"shift" : @(shiftL), @"gracenote_group" : gracenote_group}];
        }
    }

    // If first note left shift in case it is displaced
    float group_shift = ((VFGraceNoteGroup*)group_list[0]).shift;
    for(i = 0; i < group_list.count; ++i)
    {
        gracenote_group = group_list[i][@"gracenote_group"];
        [gracenote_group preFormat];
        group_shift = gracenote_group.width + gracenote_spacing;
    }

    state.left_shift += group_shift;

    return YES;
}

- (BOOL)preFormat
{
    if(self.preFormatted)
    {
        return self.preFormatted;
    }
    [[self.formatter joinVoices:@[ self.voice ]] formatWith:@[ self.voice ] withJustifyWidth:0];
    self.width = [self.formatter getMinTotalWidth];

    return self.preFormatted;
}

- (id)beamNotes
{
    if(self.graceNotes.count > 1)
    {
        VFBeam* beam = [VFBeam beamWithNotes:self.graceNotes];

        beam.beamWidth = 3;
        beam.partialBeamLength = 4;

        self.beam = beam;
    }
    return self;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    VFStaffNote* note = self.note;

    VFLogInfo("Drawing grace note group for: %@", note);
    if(!note)
    {
        VFLogError(@"NoAttachedNote, Can't draw grace note without a parent note and parent note index.");
    }

    /*!
     *  Shift over the tick contexts of each note
     *  So that they are aligned with the note
     *  @param NSArray     array of grace notes
     *  @param VFStaffNote the note to align with
     *  @note this block seems a little unnecessary
     */
    void (^alignGraceNotesWithNote)(NSArray*, VFStaffNote*) = ^void(NSArray* grace_notes, VFStaffNote* note) {
      VFTickContext* tickContext = note.tickContext;
      ExtraPx* extraPx = [tickContext getExtraPx];
      float x = tickContext.x - extraPx.left - extraPx.extraLeft;
      [grace_notes foreach:^(VFGraceNote* graceNote, NSUInteger index, BOOL* stop) {
        VFTickContext* tick_context = graceNote.tickContext;
        float x_offset = tick_context.x;
        graceNote.staff = note.staff;
        tick_context.x = x + x_offset;
      }];
    };

    alignGraceNotesWithNote(self.graceNotes, note);

    // Draw notes
    [self.graceNotes foreach:^(VFGraceNote* graceNote, NSUInteger index, BOOL* stop) {
      [graceNote draw:ctx];
    }];

    // Draw beam
    if(self.beam)
    {
        [self.beam draw:ctx];
    }

    if(self.showSlur)
    {
        // Create and draw slur
        self.slur = [[VFStaffTie alloc] initWithLastNote:self.graceNotes[0]
                                               firstNote:note
                                            firstIndices:@[ @0 ]
                                             lastIndices:@[ @0 ]];

        self.slur.cp2 = 12;
        [self.slur draw:ctx];
    }
}
@end
