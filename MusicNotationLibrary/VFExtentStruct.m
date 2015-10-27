//
//  VFExtent.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFExtentStruct.h"

@implementation VFExtentStruct

- (instancetype)initWithTopY:(float)topY andBaseY:(float)baseY
{
    self = [super init];
    if (self) {
        _topY = topY;
        _baseY = baseY;
    }
    return self;
}

+ (VFExtentStruct *)extentWithTopY:(float)topY andBaseY:(float)baseY; {
    return [[VFExtentStruct alloc]initWithTopY:topY andBaseY:baseY];
}

@end


//======================================================================================================================
#pragma mark - StemExtent Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name StemExtent Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@implementation StemExtent
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.item1 = 0; // self.baseY = 0;
//        self.item2 = 0; // self.topY = self.baseY;
//    }
//    return self;
//}
//- (float)baseY {
//    return self.item1;
//}
//- (void)setBaseY:(float)baseY {
//    self.item1 = baseY;
//}
//- (float)topY {
//    return self.item2;
//}
//- (void)setTopY:(float)topY {
//    self.item2 = topY;
//}
//
//@end