//
//  VFGraceNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFGraceNote.h"
#import "VFVex.h"
#import "VFStaffNote.h"
#import "VFBezierPath.h"
#import "VFTableTypes.h"
#import "VFRenderOptions.h"

@implementation GraceNoteOptions
@end

@implementation VFGraceNote

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        // TODO: slash slur properties need work
        if(optionsDict[@"isSlash"])
        {
            self.isSlash = [optionsDict[@"isSlash"] boolValue];
        }
        [self setupGraceNote];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setupGraceNote
{
    self->_renderOptions = [[GraceNoteOptions alloc] initWithDictionary:nil];

    GraceNoteOptions* renderOptions = self->_renderOptions;
    [renderOptions setGlyphFontScale:22];
    [renderOptions setStemHeight:20];
    [renderOptions setStrokePoints:2];
    //    self.stemHeight = 20;
    //    _stroke_px = 2;
    self.glyphStruct.head_width = 6;
    self.isSlur = YES;
    //    [self buildNodeHeads];
    self.width = 3;
}

- (float)getStemExtension
{
    if(self.stem_extension_override != -1)
    {
        return self.stem_extension_override;
    }

    if(self.glyphStruct != nil)
    {
        return self.stemDirection == 1 ? self.glyphStruct.gracenote_stem_up_extension
                                       : self.glyphStruct.gracenote_stem_down_extension;
    }

    return 0;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"gracenotes";
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    CGFloat x = self.absoluteX;
    CGFloat y = [[self.ys objectAtIndex:0] floatValue];

    if(self.isSlash)
    {
        VFBezierPath* bPath = [VFBezierPath bezierPath];
        [bPath setLineWidth:1.0];
        [VFColor.blackColor setStroke];
        [VFColor.blackColor setFill];
        if(self.stemDirection == VFStemDirectionUp)
        {
            x += 1;
            [bPath moveToPoint:CGPointMake(x, y)];
            [bPath addLineToPoint:CGPointMake(x + 13, y - 9)];
        }
        else if(self.stemDirection == VFStemDirectionDown)
        {
            x -= 4;
            y += 1;
            [bPath moveToPoint:CGPointMake(x, y)];
            [bPath addLineToPoint:CGPointMake(x + 13, y + 9)];
        }
        [bPath closePath];
        [bPath fill];
    }
}
@end
