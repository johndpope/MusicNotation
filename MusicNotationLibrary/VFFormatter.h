//
//  VFFormatter.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

@import Foundation;
#import "VFVex.h"

@interface Context : NSObject
/*!
 *  NSDictionary of NSNumber keys and VFModifierContext/VFTickContext values
 */
@property (strong, nonatomic) NSMutableDictionary* map;
/*!
 *  NSArray of VFModifierContext/VFTickContext
 */
@property (strong, nonatomic) NSMutableArray* array;

/*!
 *  NSArray of NSNumber
 */
@property (strong, nonatomic) NSMutableArray* list;
@property (assign, nonatomic) NSUInteger resolutionMultiplier;
@end

@class Rational, VFStaff, VFTabStaff, VFBoundingBox;

//======================================================================================================================
/** The `VFFormatter` class implements the formatting and layout algorithms that are used
      to position notes in a voice. The algorithm can align multiple voices both
      within a stave, and across multiple staves.

      To do this, the formatter breaks up voices into a grid of rational-valued
      `ticks`, to which each note is assigned. Then, minimum widths are assigned
      to each tick based on the widths of the notes and modifiers in that tick. This
      establishes the smallest amount of space required for each tick.

      Finally, the formatter distributes the left over space proportionally to
      all the ticks, setting the `x` values of the notes in each tick.


 The following demonstrates some basic usage of this class.

     VFFormatter *formatter = [[VFFormatter alloc]init];
     [formatter joinVoices:[NSArray arrayWithObject:voice]];
     [formatter formatWith:[NSArray arrayWithObject:voice] withJustifyWidth:500];

 */
@interface VFFormatter : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) float minTotalWidth;
@property (assign, nonatomic) BOOL hasMinTotalWidth;

/** points occupied per tick per measure
 */
@property (assign, nonatomic) float pixelsPerTick;
@property (strong, nonatomic) Rational* totalTicks;
@property (assign, nonatomic) float perTickableWidth;

/** maximal extra width that a tickable may occupy
 */
@property (assign, nonatomic) float maxExtraWidthPerTickable;

@property (assign, nonatomic) BOOL autoBeam;
@property (assign, nonatomic) BOOL alignRests;

@property (strong, nonatomic) Context* tContexts;
@property (strong, nonatomic) Context* mContexts;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (VFFormatter*)formatter;

+ (VFBoundingBox*)formatAndDrawWithContext:(CGContextRef)ctx
                                 dirtyRect:(CGRect)dirtyRect
                                   toStaff:(VFStaff*)staff
                                 withNotes:(NSArray*)notes;

+ (VFBoundingBox*)formatAndDrawWithContext:(CGContextRef)ctx
                                 dirtyRect:(CGRect)dirtyRect
                                   toStaff:(VFStaff*)staff
                                 withNotes:(NSArray*)notes
                                withParams:(NSDictionary*)params;

+ (VFBoundingBox*)formatAndDrawWithContext:(CGContextRef)ctx
                                 dirtyRect:(CGRect)dirtyRect
                                   toStaff:(VFStaff*)staff
                                 withNotes:(NSArray*)notes
                          withJustifyWidth:(float)justifyWidth;

+ (BOOL)formatAndDrawTabWithContext:(CGContextRef)ctx
                          dirtyRect:(CGRect)dirtyRect
                       withTabStaff:(VFTabStaff*)staff
                       withTabStaff:(VFTabStaff*)tabStaff
                        andTabNotes:(NSArray*)tabNotes
                           andNotes:(NSArray*)notes
                            andBeam:(BOOL)autobeam
                         withParams:(NSDictionary*)params;

+ (void)alignRestsToNotes:(NSArray*)notes withNoteAlignment:(BOOL)alignAllNotes andTupletAlignment:(BOOL)alignTuplets;

- (void)alignRests:(NSArray*)voices alignAllNotes:(BOOL)alignAllNotes;

- (float)preCalculateMinTotalWidth:(NSArray*)voices;

- (float)getMinTotalWidth;

- (Context*)createModifierContexts:(NSArray*)voices;
- (Context*)createTickContexts:(NSArray*)voices;

- (BOOL)preFormatWithContext:(CGContextRef)ctx voices:(NSArray*)voices staff:(VFStaff*)staff;

- (BOOL)preFormat;

- (BOOL)preFormatWith:(float)justifyWidth andContext:(CGContextRef)ctx voices:(NSArray*)voices staff:(VFStaff*)staff;

- (BOOL)postFormat;

- (id)joinVoices:(NSArray*)voices;

- (id)formatWith:(NSArray*)voices;
- (id)formatWith:(NSArray*)voices withJustifyWidth:(float)justifyWidth;
- (id)formatWith:(NSArray*)voices withJustifyWidth:(float)justifyWidth andOptions:(NSDictionary*)options;

- (id)formatToStaff:(NSArray*)voices staff:(VFStaff*)staff;
- (id)formatToStaff:(NSArray*)voices staff:(VFStaff*)staff options:(NSDictionary*)options;

- (void)draw:(CGContextRef)ctx;

@end
