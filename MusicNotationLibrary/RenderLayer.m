//
//  RenderLayer.m
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "RenderLayer.h"
#import "TestTuple.h"
#import "VFVexCore.h"
#import "GlyphLayer.h"

#define RENDERLAYER_BORDER_WIDTH 4.0

@interface RenderLayer ()

@property (assign, nonatomic) SEL selector;
@property (strong, nonatomic) id target;
@property (strong, nonatomic) TestTuple* testTuple;
@property (strong, nonatomic) NSString* testName;

@end


//#ifdef TARGET_OS_IPHONE
//@implementation RenderLayer
//@end
//#elif TARGET_OS_MAC

@implementation RenderLayer


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.borderColor = nil;
 
    }
    return self;
}

- (TestTuple*)invokeTest
{
    NSMethodSignature* signature = [_target methodSignatureForSelector:self.selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:self.selector];
    [invocation setTarget:self.target];
    //    NSString* name = @"";

    // set the TestCollectionItemView
    id arg2 = self.parentView;
    [invocation setArgument:&arg2 atIndex:2];
    //    [invocation setArgument:&ctx atIndex:3];

    // set additional params
    if(self.testAction)
    {
        if(self.testAction.params)
        {
            id arg3 = _testAction.params;
            [invocation setArgument:&arg3 atIndex:3];
        }
    }

    [invocation invoke];
    TestTuple* ret __unsafe_unretained;   // http://stackoverflow.com/a/22034059/629014
    [invocation getReturnValue:&ret];
    self.testTuple = ret;
    return ret;
}

- (void)setNeedsDisplay
{
    //    if(_testTuple)
    //    {
    [super setNeedsDisplay];
    //    }
    //    else
    //    {
    //        NSLog(@"need to setup layer first.");
    //    }
}

- (void)setTestAction:(TestAction*)testAction
{
    _testAction = testAction;
    self.selector = _testAction.selector;
    self.target = _testAction.target;
    self.testName = _testAction.name;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [self invokeTest];
      dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
      });
    });
}

- (void)clearLayer
{
    _testTuple = nil;
    [self setNeedsDisplay];
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx
{
    CGRect dirtyRect = self.bounds;

    VFBezierPath* outline = [VFBezierPath bezierPathWithRect:dirtyRect];
    [SHEET_MUSIC_COLOR setFill];
    //    [[VFColor randomBGColor:YES] setFill];
    [outline fill];

    if(!_testTuple)
    {
        return;
    }

    NSGraphicsContext* gc = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:YES];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:gc];

    VFStaff* staff;
    if(self.testTuple.staves.count > 0)
    {
        staff = self.testTuple.staves[0];
    }
    
    if (self.testTuple.voices.count == 0) {
        [staff draw:ctx];
    }
    
    for(NSUInteger i = 0; i < self.testTuple.voices.count; ++i)
    {
        if(self.testTuple.staves.count == i + 1)
        {
            staff = self.testTuple.staves[i];
        }
        [staff draw:ctx];
        VFVoice* voice = self.testTuple.voices[i];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
    }

    for(NSUInteger i = 0; i < self.testTuple.beams.count; ++i)
    {
        VFBeam* beam = self.testTuple.beams[i];
        [beam draw:ctx];
    }

    if(self.testTuple.drawBlock)
    {
        self.testTuple.drawBlock(CGRectZero, self.bounds, ctx);
    }

    //    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.alignment = kCTTextAlignmentLeft;
    //
    //#if TARGET_OS_IPHONE
    //    UIFont* font1 = [UIFont fontWithName:@"Helvetica" size:12];
    //#elif TARGET_OS_MAC
    //    NSFont* font1 = [NSFont fontWithName:@"Helvetica" size:12];
    //#endif
    //
    //    VFFont* font1 = [VFFont fontWithName:@"Helvetica" size:12];

    // TODO: change to NSTextField
    //    NSAttributedString* titleString = [[NSAttributedString alloc]
    //        initWithString:self.testName
    //            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
    //    [titleString drawAtPoint:CGPointMake(10, 10)];

    [NSGraphicsContext restoreGraphicsState];
}

- (VFStaffNote*)showStaffNote:(VFStaffNote*)ret
                      onStaff:(VFStaff*)staff
                  withContext:(CGContextRef)ctx
                          atX:(float)x
              withBoundingBox:(BOOL)drawBoundingBox
{
    VFLogInfo(@"");
    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [[tickContext addTickable:ret] preFormat];
    tickContext.x = x;
    tickContext.pixelsUsed = 20;
    ret.staff = staff;
    [ret draw:ctx];
    if(drawBoundingBox)
    {
        [ret.boundingBox draw:ctx];
    }
    return ret;
}

- (VFStaffNote*)showNote:(NSDictionary*)noteStruct onStaff:(VFStaff*)staff withContext:(CGContextRef)ctx atX:(float)x
{
    return [self showNote:noteStruct onStaff:staff withContext:ctx atX:x withBoundingBox:NO];
}

- (VFStaffNote*)showNote:(NSDictionary*)noteStruct
                 onStaff:(VFStaff*)staff
             withContext:(CGContextRef)ctx
                     atX:(float)x
         withBoundingBox:(BOOL)drawBoundingBox
{
    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:noteStruct];
    return [self showStaffNote:ret onStaff:staff withContext:ctx atX:x withBoundingBox:drawBoundingBox];
}

//- (void)setBorderColor:(NSColor*)newBorderColor
- (void)setBorderColor:(CGColorRef)borderColor
{
    //    if(_borderColor != [NSColor colorWithCGColor:borderColor])
    //    {
    //        _borderColor = [NSColor colorWithCGColor:borderColor];
    //        NSColor* borderColor = [NSColor blueColor];
    //        self.borderColor = _borderColor.CGColor;
    [super setBorderColor:borderColor];
    self.borderWidth = (self.borderColor ? RENDERLAYER_BORDER_WIDTH : 0.0);
    //        [self setNeedsDisplay];
    //    }
}

- (void)addSublayer:(CALayer *)layer
{
    [super addSublayer:layer];
}

- (BOOL)pointingDeviceDownEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    BOOL handled = NO;

    for(CALayer* sublayer in self.sublayers.reverseObjectEnumerator)
    {
        if(sublayer && [sublayer conformsToProtocol:@protocol(LayerResponder)])   //||
        //           [sublayer respondsToSelector:@selector(pointingDeviceDownEvent:atPoint:)])
        {
            CGPoint pointInHostedLayer = [self convertPoint:interactionPoint toLayer:sublayer];
            handled = [((id<LayerResponder>)sublayer) pointingDeviceDownEvent:event atPoint:pointInHostedLayer];
            if(handled)
            {
                break;
            }
        }
    }

    return handled;
}

- (BOOL)pointingDeviceUpEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    return NO;
}

- (BOOL)pointingDeviceDraggedEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    return NO;
}

- (BOOL)pointingDeviceCancelledEvent:(NSEvent*)event
{
    return NO;
}

@end

//#endif