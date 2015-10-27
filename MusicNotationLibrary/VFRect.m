//
//  VFRect.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFRect.h"

@interface VFRect()
@property (assign, nonatomic) CGRect rect;
@end

@implementation VFRect

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRect];
    }
    return self;
}

- (instancetype)initWithRect:(CGRect)rect {
    self = [super init];
    if (self) {
        [self setupRect];
        _r = rect;
        _x = self.rect.origin.x;
        _y = self.rect.origin.y;
        _w = self.rect.size.width;
        _h = self.rect.size.height;
    }
    return self;
}

- (instancetype)initAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height {
    self = [self init];
    if (self) {
        [self setupRect];
        _r = CGRectMake(x, y, width, height);
        _x = x;
        _y = y;
        _w = width;
        _h = height;
    }
    return self;
}


- (void)setupRect {
    _r = CGRectZero;
    _x = 0.0;
    _y = 0.0;
    _w = 0.0;
    _h = 0.0;
}


#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@synthesize xPosition = _x;
@synthesize yPosition = _y;
@synthesize width = _w;
@synthesize height = _h;
@synthesize rect = _r;

- (void)setX:(float)x {
    _x = x;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setY:(float)y {
    _y = y;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setW:(float)w {
    _w = w;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setH:(float)h {
    _h = h;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setRect:(CGRect)rect {
    _r = rect;
    _x = _r.origin.x;
    _y = _r.origin.y;
    _w = _r.size.width;
    _h = _r.size.height;
}

- (CGPoint)origin {
    return CGPointMake(self.xPosition, self.yPosition);
}

- (float)xEnd {
    return self.rect.origin.x + self.rect.size.width;
}

- (float)yEnd {
    return self.rect.origin.y + self.rect.size.height;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (VFRect *)boundingBoxAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height {
    return [[VFRect alloc] initAtX:x atY:y withWidth:width andHeight:height];
}

+ (VFRect *)boundingBoxZero {
    return [[VFRect alloc]init];
}

+ (VFRect *)boundingBoxWithRect:(CGRect)rect {
    return [[VFRect alloc]initWithRect:rect];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"rect: (%f, %f, %f, %f)\n", self.xPosition, self.yPosition, self.width, self.height];
}

- (void)mergeWithBox:(VFRect *)box; { // andDrawWthContext:(CGContextRef)ctx; {
    [self setRect:CGRectUnion(self.rect, box.rect)];
    
    //    if (context != nil)
    //        [self draw:context];
}

@end
