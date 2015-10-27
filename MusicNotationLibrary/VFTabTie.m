//
//  VFTabTie.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTabTie.h"

@implementation VFTabTie
{
}

/*
 // VexFlow - Music Engraving for HTML5
 // Copyright Mohit Muthanna 2010
 //
 // This class implements varies types of ties between contiguous notes. The
 // ties include: regular ties, hammer ons, pull offs, and slides.

 **
 * Create a new tie from the specified notes. The notes must
 * be part of the same line, and have the same duration (in ticks).
 *
 * @constructor
 * @param {!Object} context The canvas context.
 * @param {!Object} notes The notes to tie up.
 * @param {!Object} Options
 *
Vex.Flow.TabTie = function(notes, text) {
    if (arguments.count > 0) self.init(notes, text);
}
 */

/*
Vex.Flow.TabTie.prototype = new Vex.Flow.StaffTie();
Vex.Flow.TabTie.prototype.constructor = Vex.Flow.TabTie;
Vex.Flow.TabTie.superclass = Vex.Flow.StaffTie.prototype;
 */
- (instancetype)initTabTie
{
    self = [super init];
    if(self)
    {
        [self setupTabTie];
    }
    return self;
}

- (void)setupTabTie
{
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*
Vex.Flow.TabTie.createHammeron = function(notes) {
    return new Vex.Flow.TabTie(notes, "H");
}
 */

/*
Vex.Flow.TabTie.createPulloff = function(notes) {
    return new Vex.Flow.TabTie(notes, "P");
 }*/

/*

Vex.Flow.TabTie.prototype.init = function(notes, text) {
    **
     * Notes is a struct that has:
     *
     *  {
     *    first_note: Note,
     *    last_note: Note,
     *    first_indices: [n1, n2, n3],
     *    last_indices: [n1, n2, n3]
     *  }
     *
     **
    Vex.Flow.TabTie.superclass.init.call(this, notes, text);
    self.render_options.cp1 = 9;
    self.render_options.cp2 = 11;
    self.render_options.y_shift = 3;

    self.setNotes(notes);
 }*/

/*

Vex.Flow.TabTie.prototype.draw = function() {
    if (!self.context)
        throw new Vex.RERR("NoContext", "No context to render tie.");
    var first_note = self.first_note;
    var last_note = self.last_note;
    var first_x_px, last_x_px, first_ys, last_ys;

    if (first_note) {
        first_x_px = first_note.getTieRightX() + self.render_options.tie_spacing;
        first_ys = first_note.getYs();
    } else {
        first_x_px = last_note.getStaff().getTieStartX();
        first_ys = last_note.getYs();
        self.first_indices = self.last_indices;
    };

    if (last_note) {
        last_x_px = last_note.getTieLeftX() + self.render_options.tie_spacing;
        last_ys = last_note.getYs();
    } else {
        last_x_px = first_note.getStaff().getTieEndX();
        last_ys = first_note.getYs();
        self.last_indices = self.first_indices;
    }

    self.renderTie({
    first_x_px: first_x_px,
    last_x_px: last_x_px,
    first_ys: first_ys,
    last_ys: last_ys,
    direction: -1           // Tab tie's are always face up.
    });

    self.renderText(first_x_px, last_x_px);
    return YES;
}

 */

@end
