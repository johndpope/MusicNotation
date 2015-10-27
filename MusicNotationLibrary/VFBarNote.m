//
//  VFBarNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFBarNote.h"
#import "VFVex.h"

@implementation VFBarNote
{
}
/*
 // Vex Flow Notation
 // Mohit Muthanna <mohit@muthanna.com>
 //
 // Copyright Mohit Muthanna 2010
 //
 // Requires vex.js.

 * @constructor *
 Vex.Flow.BarNote = function() { self.init(); }
 Vex.Flow.BarNote.prototype = new Vex.Flow.Note();
 Vex.Flow.BarNote.superclass = Vex.Flow.Note.prototype;
 Vex.Flow.BarNote.constructor = Vex.Flow.BarNote;
 */

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupBarNote];
    }
    return self;
}

- (void)setupBarNote
{
    /*
    Vex.Flow.BarNote.prototype.init = function() {
        var superclass = Vex.Flow.BarNote.superclass;
        superclass.init.call(this, {duration: "b"});

        var TYPE = Vex.Flow.Barline.type;
        self.metrics = {
        widths: {}
        }

        self.metrics.widths[TYPE.SINGLE] = 8;
        self.metrics.widths[TYPE.DOUBLE] = 12;
        self.metrics.widths[TYPE.END] = 15;
        self.metrics.widths[TYPE.REPEAT_BEGIN] = 14;
        self.metrics.widths[TYPE.REPEAT_END] = 14;
        self.metrics.widths[TYPE.REPEAT_BOTH] = 18;
        self.metrics.widths[TYPE.NONE] = 0;

        // Note properties
        self.ignore_ticks = YES;
        self.type = TYPE.SINGLE;
        self.setWidth(self.metrics.widths[self.type]);
     }*/
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setType:(VFBarNoteType)type
{
    /*

    Vex.Flow.BarNote.prototype.setType = function(type) {
        self.type = type;
        self.setWidth(self.metrics.widths[self.type]);
        return this;
    }
     */
}

- (VFBarNoteType)type
{
    /*
    Vex.Flow.BarNote.prototype.getType = function() {
        return self.type;
    }
     */
    return 0;
}

- (void)setStaff:(VFStaff*)Staff
{
    /*
    Vex.Flow.BarNote.prototype.setStaff = function(Staff) {
        var superclass = Vex.Flow.BarNote.superclass;
        superclass.setStaff.call(this, Staff);
    }
     */
}

- (VFStaff*)staff
{
    return nil;
}

- (CGRect)bounds
{
    /*
    Vex.Flow.BarNote.prototype.getBoundingBox = function() {
        return new Vex.Flow.BoundingBox(0, 0, 0, 0);
    }
     */
    return CGRectZero;
}

/*
Vex.Flow.BarNote.prototype.addToModifierContext = function(mc) {
    return this;
}
 */

- (void)setPreFormatted:(BOOL)preFormatted
{
    /*
    Vex.Flow.BarNote.prototype.preFormat = function() {
        self.setPreFormatted(YES);
        return this;
    }
     */
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    /*
    Vex.Flow.BarNote.prototype.draw = function() {
        if (!self.Staff) throw new Vex.RERR("NoStaff", "Can't draw without a Staff.");
    //
    //    *
    //     var x = self.getAbsoluteX() + self.x_shift;
    //     if (self.type == Vex.Flow.BarNote.TYPE.SINGLE) {
    //     self.Staff.drawVerticalBarFixed(x);
    //     } else if (self.type == Vex.Flow.BarNote.TYPE.DOUBLE) {
    //     self.Staff.drawVerticalBarFixed(x);
    //     self.Staff.drawVerticalBarFixed(x + self.metrics.double_x_shift);
    //     }
    //     *
        var barline = new Vex.Flow.Barline(self.type, self.getAbsoluteX());
        barline.draw(self.Staff, self.getAbsoluteX());
    }

    */
}
@end
