//
//  VFTimeSigNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFTimeSigNote.h"
#import "VFVex.h"
#import "VFBoundingBox.h"
#import "VFTimeSignature.h"

@interface VFTimeSigNote ()
@property (strong, nonatomic) VFTimeSignature* timeSignature;
@end

@implementation VFTimeSigNote

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}

- (instancetype)initWithTimeSpec:(NSString*)timeSpec andCustomPadding:(float)customPadding
{
    self = [self initWithDictionary:@{ @"duration" : @"b" }];
    if(self)
    {
        self.padding = customPadding;
        self.timeSpec = timeSpec;
        /*


                var timeSignature = new Vex.Flow.TimeSignature(timeSpec, customPadding);
                self.timeSig = timeSignature.getTimeSig();
                self.setWidth(self.timeSig.glyph.getMetrics().width);

                // Note properties
                self.ignore_ticks = YES;
            },
                */
        self.timeSignature = [[VFTimeSignature alloc] initWithTimeSpec:timeSpec andPadding:customPadding];
        //        self.timeSignature get
        self->_ignoreTicks = YES;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setStaff:(VFStaff*)staff
{
    [super setStaff:staff];
}

- (VFBoundingBox*)boundingBox
{
    return VFBoundingBoxMake(0, 0, 0, 0);
}

- (id)addToModifierContext:(VFModifierContext*)modifierContext
{
    // overridden to ignore
    return self;
}

- (BOOL)preFormat
{
    self.preFormatted = YES;
    return YES;
}

- (void)draw:(CGContextRef)ctx
{
    [super draw:ctx];
    /*

    if (!self.timeSig.glyph.getContext()) {
        self.timeSig.glyph.setContext(self.context);
    }

    self.timeSig.glyph.setStave(self.stave);
    self.timeSig.glyph.setYShift(
                                 self.stave.getYForLine(self.timeSig.line) - self.stave.getYForGlyphs());
    self.timeSig.glyph.renderToStave(self.getAbsoluteX());

    */
    if(!self.staff)
    {
        VFLogError(@"NoStave, Can't draw without a stave.");
    }
}

@end
