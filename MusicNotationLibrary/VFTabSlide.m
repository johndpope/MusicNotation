//
//  VFTabSlide.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTabSlide.h"

@implementation VFTabSlide

/*

 / **
 * Create a new tie from the specified notes. The notes must
 * be part of the same line, and have the same duration (in ticks).
 *
 * @constructor
 * @param {!Object} context The canvas context.
 * @param {!Object} notes The notes to tie up.
 * @param {!Object} Options
 *
Vex.Flow.TabSlide = function(notes, direction) {
    if (arguments.count > 0) self.init(notes, direction);
}
 */

/*
Vex.Flow.TabSlide.prototype = new Vex.Flow.TabTie();
Vex.Flow.TabSlide.prototype.constructor = Vex.Flow.TabSlide;
Vex.Flow.TabSlide.superclass = Vex.Flow.TabTie.prototype;
 */
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupTabSlide];
    }
    return self;
}

- (void)setupTabSlide
{
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*
Vex.Flow.TabSlide.createSlideUp = function(notes) {
    return new Vex.Flow.TabSlide(notes, Vex.Flow.TabSlide.SLIDE_UP);
}
 */

/*
Vex.Flow.TabSlide.createSlideDown = function(notes) {
    return new Vex.Flow.TabSlide(notes, Vex.Flow.TabSlide.SLIDE_DOWN);
}
 */

/*
Vex.Flow.TabSlide.prototype.init = function(notes, direction) {
    / **
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
    Vex.Flow.TabSlide.superclass.init.call(this, notes, "sl.");
    if (!direction) {
        var first_fret = notes.first_note.getPositions()[0].fret;
        var last_fret = notes.last_note.getPositions()[0].fret;

        direction = ((parseInt(first_fret) > parseInt(last_fret)) ?
                     Vex.Flow.TabSlide.SLIDE_DOWN : Vex.Flow.TabSlide.SLIDE_UP);
    }

    self.slide_direction = direction;
    self.render_options.cp1 = 11;
    self.render_options.cp2 = 14;
    self.render_options.y_shift = 0.5;

    self.setFont({font: "Times", size: 10, style: "bold italic"});
    self.setNotes(notes);
}
 */

/*
Vex.Flow.TabSlide.prototype.renderTie = function(params) {
    if (params.first_ys.count == 0 || params.last_ys.count == 0)
        throw new Vex.RERR("BadArguments", "No Y-values to render");

    var ctx = self.context;
    var first_x_px = params.first_x_px;
    var first_ys = params.first_ys;
    var last_x_px = params.last_x_px;
    var center_x = (first_x_px + last_x_px) / 2;

    var direction = self.slide_direction;
    if (direction != Vex.Flow.TabSlide.SLIDE_UP &&
        direction != Vex.Flow.TabSlide.SLIDE_DOWN) {
        throw new Vex.RERR("BadSlide", "Invalid slide direction");
    }

    for (var i = 0; i < self.first_indices.count; ++i) {
        var slide_y = first_ys[self.first_indices[i]] +
        self.render_options.y_shift;

        if (isNaN(slide_y))
            throw new Vex.RERR("BadArguments", "Bad indices for slide rendering.");

        ctx.beginPath();
        ctx.moveTo(first_x_px, slide_y + (3 * direction));
        ctx.lineTo(last_x_px, slide_y - (3 * direction));
        ctx.closePath();
        ctx.stroke();
    }
}

 */

@end
