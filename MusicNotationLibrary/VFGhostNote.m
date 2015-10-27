//
//  VFGhostNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFGhostNote.h"
#import "VFVex.h"
#import "VFModifier.h"

@implementation VFGhostNote

//- (instancetype)initWithNote:(VFNote *)note {
//    self = [super initWithNote:note];
//    if (self) {
//        [self setupGhostNote];
//    }
//    return self;
//}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setupsetupGhostNote
{
}

- (BOOL)isRest
{
    return YES;
}

- (id)addToModifierContext
{
    return self;
}

- (BOOL)preFormat
{
    //    [self setPreformatted:YES];
    self.preFormatted = YES;
    return YES;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(self.staff == nil)
    {
        [VFLog logError:@"NoStaff, Can't draw without a staff."];
    }

    for(NSUInteger i = 0; i < self.modifiers.count; ++i)
    {
        VFModifier* modifier = (VFModifier*)[self.modifiers objectAtIndex:i];
        // TODO: change modifier to draw by passing graphicscontext
        [modifier draw:ctx];
    }
}

@end
