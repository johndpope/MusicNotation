//
//  VFPadding.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFPadding.h"
#import "VFPoint.h"

@implementation VFPadding

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupPadding];
    }
    return self;
}

- (instancetype)initWithXRightPadding:(float)xRight
            andXLeftPadding:(float)xLeft
              andYUpPadding:(float)yUp
            andYDownPadding:(float)yDown {
    self = [super init];
    if (self) {
        [self setupPadding];
        _xRightPadding = xRight;
        _xLeftPadding = xLeft;
        _yUpPadding = yUp;
        _yDownPadding = yDown;
    }
    return self;
}

- (instancetype)initWithXRightPadding:(float)xRight
            andXLeftPadding:(float)xLeft {
    self = [super init];
    if (self) {
        [self setupPadding];
        _xRightPadding = xRight;
        _xLeftPadding = xLeft;
    }
    return self;
}

- (instancetype)initWithX:(float)x
           andY:(float)y {
    self = [super init];
    if (self) {
        [self setupPadding];
        _point = [VFPoint pointWithX:x andY:y];
    }
    return self;
}

- (void)setupPadding {
    _point = [VFPoint pointZero];
    _xRightPadding = 0;
    _xLeftPadding = 0;
    _yUpPadding = 0;
    _yDownPadding = 0;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (float)width {
    return self.xLeftPadding + self.xRightPadding;
}

- (float)height {
    return self.yDownPadding + self.yUpPadding;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (VFPadding *)paddingWithX:(float)x
                       andY:(float)y {
    return [[VFPadding alloc] initWithX:x andY:y];
}

+ (VFPadding *)paddingWithRightPadding:(float)xRight
                       andXLeftPadding:(float)xLeft
                         andYUpPadding:(float)yUp
                       andYDownPadding:(float)yDown {
    return [[VFPadding alloc] initWithXRightPadding:xRight andXLeftPadding:xLeft andYUpPadding:yUp andYDownPadding:yDown];
}

+ (VFPadding *)paddingWith:(float)padding {
    return [VFPadding paddingWithRightPadding:padding andXLeftPadding:padding andYUpPadding:padding andYDownPadding:padding];
}

+ (VFPadding *)paddingZero {
    return [[VFPadding alloc]initWithXRightPadding:0 andXLeftPadding:0 andYUpPadding:0 andYDownPadding:0];
}


- (void)addPaddingToAllSidesWith:(float)padding {
    _xRightPadding += padding;
    _xLeftPadding += padding;
    _yUpPadding += padding;
    _yDownPadding += padding;
}


- (void)padAllSidesBy:(float)padding {
    _xRightPadding = padding;
    _xLeftPadding = padding;
    _yUpPadding = padding;
    _yDownPadding = padding;
}

@end
