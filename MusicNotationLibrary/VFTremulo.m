//
//  VFTremulo.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTremulo.h"
#import "VFVex.h"
#import "VFStaffNote.h"
#import "VFGlyph.h"

@implementation VFTremulo

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        self.index = -999;
        self.position = VFPositionCenter;
        self.code = @"v74";
        self.shift_right = -2;
        self.y_spacing = 4;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (NSString*)category
{
    return @"tremolo";
}

- (void)draw:(CGContextRef)ctx
{
    if(!(self.note && (self.index)))
    {
        VFLogError(@"NoAttachedNote, Can't draw Tremolo without a note and index.");
    }

    VFPoint* start = [self.note getModifierstartXYforPosition:self.position andIndex:self.index];
    float x = start.x;
    float y = start.y;

    x += self.shift_right;
    for(NSUInteger i = 0; i < self.num; ++i)
    {
        [VFGlyph renderGlyph:ctx atX:x atY:y withScale:1 forGlyphCode:self.code];
        y += self.y_spacing;
    }
}

@end
