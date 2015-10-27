
//
//  VFTabStaff.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTabStaff.h"
#import "VFVex.h"
#import "VFStaff.h"
#import "VFGlyph.h"

@implementation VFTabStaff

//- (instancetype)initAtX:(float)x atY:(float)y width:(float)width height:(float)height optionsDict:(NSDictionary
//*)optionsDict:(float)width andOptions:(Options*)options
//{

- (instancetype)initAtX:(float)x atY:(float)y width:(float)width height:(float)height
{
    self = [super initAtX:x atY:y width:width height:height optionsDict:@{}];
    if(self)
    {
        [self setupTabStaff];
    }
    return self;
}

//- (instancetype)initWithBoundingBox:(VFBoundingBox *)frame
//{
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}

+ (VFTabStaff*)staffWithRect:(CGRect)rect
{
    return [[VFTabStaff alloc] initAtX:CGRectGetMinX(rect)
                                   atY:CGRectGetMinY(rect)
                                 width:CGRectGetWidth(rect)
                                height:CGRectGetHeight(rect)];
}

+ (VFTabStaff*)staffAtX:(float)x atY:(float)y width:(float)width height:(float)height;
{
    return [[VFTabStaff alloc] initAtX:x atY:y width:width height:height];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

//- (instancetype)initAtX:(float)x
//         andY:(float)y
//    withWidth:(float)width
//   andOptions:(Options *)options {
//
//    /*
//     Vex.Flow.TabStaff.prototype.init = function(x, y, width, options) {
//     var superclass = Vex.Flow.TabStaff.superclass;
//
//
//     Vex.Merge(tab_options, options);
//     superclass.init.call(this, x, y, width, tab_options);
//     }
//     */
//
//    self = [super in initAtX:x atY:y withWidth:width andHeight:0];
//    if (self) {
//        [self setupTabStaff];
//
//        //TODO: do a merge here of options
//    }
//    return self;
//}
//
//- (instancetype)initWithBoundingBox:(VFBoundingBox *)frame {
//    self = [super initWithBoundingBox:frame];
//    if (self) {
//        [self setupTabStaff];
//    }
//    return self;
//}

- (void)setupTabStaff
{
    /*
     var tab_options = {
     spacing_between_lines_px: 13,
     num_lines: 6,
     top_text_position: 1,
     bottom_text_position: 7
     };
     */
    self.options.pointsBetweenLines = 13;
    self.options.numLines = 6;
    self.options.topTextPosition = 1;
    self.options.bottomTextPosition = 7;
}
//
//+ (VFTabStaff*)tabStaffWithBoundingBox:(VFBoundingBox*)boundingBox
//{
//    return [[VFTabStaff alloc] initWithBoundingBox:boundingBox];
//}

- (void)setNumberOfLines:(float)numberOfLines
{
    /*
    Vex.Flow.TabStaff.prototype.setNumberOfLines = function(lines) {
        self.options.num_lines = lines; return this;
    }
     */
    self.options.numLines = numberOfLines;
}

- (float)getYForGlyphs
{
    /*
    Vex.Flow.TabStaff.prototype.getYForGlyphs = function() {
        return self.getYForLine(2.5);
    }
     */
    return [self getYForLine:2.5];
}

- (id)addTabGlyph
{
    /*
    Vex.Flow.TabStaff.prototype.addTabGlyph = function() {
        var glyphScale;
        var glyphOffset;

        switch(self.options.num_lines) {
            case 6:
                glyphScale = 40;
                glyphOffset = 0;
                break;
            case 5:
                glyphScale = 30;
                glyphOffset = -6;
                break;
            case 4:
                glyphScale = 23;
                glyphOffset = -12;
                break;
        }

        var tabGlyph = new Vex.Flow.Glyph("v2f", glyphScale);
        tabGlyph.y_shift = glyphOffset;
        self.addGlyph(tabGlyph);
        return this;
    }

     */
    float glyphScale = 0;
    float glyphOffset = 0;

    switch(self.options.numLines)
    {
        case 8:
            glyphScale = 55;
            glyphOffset = 14;
            break;
        case 7:
            glyphScale = 47;
            glyphOffset = 8;
            break;
        case 6:
            glyphScale = 40;
            glyphOffset = 1;
            break;
        case 5:
            glyphScale = 30;
            glyphOffset = -6;
            break;
        case 4:
            glyphScale = 23;
            glyphOffset = -12;
            break;
    }

    VFGlyph* tabGlyph = [[VFGlyph alloc] initWithCode:@"v2f" withScale:1]; //glyphScale];
    tabGlyph.y_shift = glyphOffset;
    [self addGlyph:tabGlyph];
    return self;
}

- (void)draw:(CGContextRef)ctx
{
    [super draw:ctx];
}

@end
