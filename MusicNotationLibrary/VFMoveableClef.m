//
//  VFMovableClef.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFMoveableClef.h"
#import "VFStaff.h"
#import "VFMetrics.h"
#import "VFPoint.h"

@implementation VFMovableClef

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)init
{
    self = [super initWithType:VFClefMovableC];
    if(self)
    {
        self.type = VFClefMovableC;
        [((Metrics*)self->_metrics)setName:@"MoveableC"];
        [self setCodeAndName];
        [self setupMovableCClef];
    }
    return self;
}

- (void)setupMovableCClef
{
    [((Metrics*)self->_metrics)setLine:INT32_MAX];
    [((Metrics*)self->_metrics)setCode:@"v12"];
    self.startingPitch = 39;
    [((Metrics*)self->_metrics)setPoint:[VFPoint pointZero]];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)setLine:(float)line
{
    [((Metrics*)self->_metrics)setLine:line];
    //    self.metrics.st
}

- (float)line
{
    return [((Metrics*)self->_metrics)line];
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (BOOL)preFormat
{
    return [super preFormat];
}

#pragma mark - Rendering
/**---------------------------------------------------------------------------------------------------------------------
 * @name Rendering
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)draw:(CGContextRef)ctx
{
    // additional drawing code here...
    if([((Metrics*)self->_metrics)line] == INT32_MAX)
    {
        [VFLog logError:@"VFClefMovableCException, remember to set the line number."];
    }

    [super draw:ctx];
}

//- (void) renderToStaff:(CGContextRef)ctx {
//    // additional drawing code here...
//    if (self.metrics.line == INT32_MAX) {
//        [VFLog LogError:@"VFClefMovableCException, remember to set the line number."];
//    }
//
//    [super renderToStaff:context];
//
//}

@end
