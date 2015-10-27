//
//  ScrollViewTests.m
//  VexFlow
//
//  Created by Scott on 5/9/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "ScrollViewTests.h"
#import "VexFlowTestHelpers.h"

/*
typedef void (^DrawColorBoxBlock)(CGRect dirtyRect, CGRect bounds);

@interface ColorBox : NSView
@property (strong, nonatomic) DrawColorBoxBlock drawBlock;
@property (strong, nonatomic) NSColor* backGroundColor;
@property (strong, nonatomic) NSColor* circleColor;
@end

@implementation ColorBox

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if(self)
    {
        __weak typeof(self) weakSelf = self;
        self.drawBlock = ^(CGRect dirtyRect, CGRect bounds) {
          [[NSColor clearColor] set];
          NSRectFill(dirtyRect);   // weakSelf.bounds);

          CGPoint center;
          center.x = CGRectGetMidX(weakSelf.bounds);
          center.y = CGRectGetMidY(weakSelf.bounds);

          NSBezierPath* outline = [NSBezierPath bezierPathWithRect:weakSelf.bounds];
          [weakSelf.backGroundColor setFill];
          [VFColor.blackColor setStroke];
          [outline fill];

          NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
          paragraphStyle.alignment = kCTTextAlignmentCenter;
          NSFont* font1 = [NSFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25];
          NSString* titleMessage = [NSString stringWithFormat:@"%lu", (unsigned long)[[weakSelf class] count]];
          NSAttributedString* title = [[NSAttributedString alloc]
              initWithString:titleMessage
                  attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
          [title drawInRect:CGRectMake(CGRectGetMidX(weakSelf.bounds), CGRectGetMidY(weakSelf.bounds), 40, 30)];

          NSGraphicsContext* aContext = [NSGraphicsContext currentContext];
          CGContextRef ctx = aContext.CGContext;

          CGContextSaveGState(ctx);

          CGContextSetLineWidth(ctx, 5);
          CGContextSetStrokeColorWithColor(ctx, weakSelf.circleColor.CGColor);
          CGContextAddArc(ctx, center.x, center.y, 10, 0.0, M_PI * 2, YES);
          CGContextStrokePath(ctx);

          CGContextRestoreGState(ctx);

        };
    }
    return self;
}

- (BOOL)isOpaque
{
    return NO;
}

- (void)drawRect:(NSRect)dirtyRect
{
    self.drawBlock(dirtyRect, self.bounds);
    NSLog(@"drawRect %lu %@", _count, NSStringFromRect(dirtyRect));

    //    typeof(self) weakSelf = self;
    //    [[NSColor clearColor] set];
    //    NSRectFill(dirtyRect);   // weakSelf.bounds);
    //
    //    CGPoint center;
    //    center.x = CGRectGetMidX(weakSelf.bounds);
    //    center.y = CGRectGetMidY(weakSelf.bounds);
    //
    //    NSBezierPath* outline = [NSBezierPath bezierPathWithRect:weakSelf.bounds];
    //    [weakSelf.backGroundColor setFill];
    //    [VFColor.blackColor setStroke];
    //    [outline fill];
    //
    //    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.alignment = kCTTextAlignmentCenter;
    //    NSFont* font1 = [NSFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25];
    //    NSString* titleMessage = [NSString stringWithFormat:@"%lu", (unsigned long)[[weakSelf class] count]];
    //    NSAttributedString* title = [[NSAttributedString alloc]
    //        initWithString:titleMessage
    //            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
    //    [title drawInRect:CGRectMake(CGRectGetMidX(weakSelf.bounds), CGRectGetMidY(weakSelf.bounds), 40, 30)];
    //
    //    NSGraphicsContext* aContext = [NSGraphicsContext currentContext];
    //    CGContextRef ctx = aContext.CGContext;
    //
    //    CGContextSaveGState(ctx);
    //
    //    CGContextSetLineWidth(ctx, 5);
    //    CGContextSetStrokeColorWithColor(ctx, weakSelf.circleColor.CGColor);
    //    CGContextAddArc(ctx, center.x, center.y, 10, 0.0, M_PI * 2, YES);
    //    CGContextStrokePath(ctx);
    //
    //    CGContextRestoreGState(ctx);
}

static NSUInteger _count = 0;
+ (NSUInteger)count
{
    return _count++;
}

@end

@implementation ScrollViewTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    for(NSUInteger i = 0; i < 3; i++)
    {
        [self runTest:@"Grid"  func:@selector(basic:)];
        [self runTest:@"Grid"  func:@selector(basic1:)];
        [self runTest:@"Grid"  func:@selector(basic2:)];
    }
}



- (void)basic:(VFTestView*)parent   // number:(NSNumber*)number
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(1200, 100) withParent:parent];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
    //    };

    __weak typeof(test) weakTest = test;
    test.loadBlock = ^(CGRect bounds) {
      BOOL skip = YES;
      for(NSInteger y = weakTest.bounds.size.height; y >= 0; y -= 100)
      {
          NSInteger startx = skip ? 0 : 100;
          skip = !skip;
          for(NSUInteger x = startx; x < weakTest.bounds.size.width; x += 200)
          {
              ColorBox* box = [[ColorBox alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
              box.backGroundColor = [VFColor randomBGColor:NO];
              box.circleColor = [VFColor randomBGColor:NO];
              [box setNeedsDisplayInRect:CGRectMake(x, y, 100, 100)];
              [weakTest addSubview:box];
          }
      }
    };
}

- (void)basic1:(VFTestView*)parent   // number:(NSNumber*)number
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(700, 200) withParent:parent];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
    //    };

    __weak typeof(test) weakTest = test;
    test.loadBlock = ^(CGRect bounds) {
      BOOL skip = YES;
      for(NSInteger y = weakTest.bounds.size.height; y >= 0; y -= 100)
      {
          NSInteger startx = skip ? 0 : 100;
          skip = !skip;
          for(NSInteger x = startx; x < weakTest.bounds.size.width; x += 200)
          {
              ColorBox* box = [[ColorBox alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
              box.backGroundColor = [VFColor randomBGColor:YES];
              box.circleColor = [VFColor randomBGColor:YES];
              [box setNeedsDisplayInRect:CGRectMake(x, y, 100, 100)];
              [weakTest addSubview:box];
          }
      }
    };
}

- (void)basic2:(VFTestView*)parent   // number:(NSNumber*)number
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(1400, 300) withParent:parent];
    test.backgroundColor = [VFColor randomBGColor:NO];

    //    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
    //    };

    __weak typeof(test) weakTest = test;
    test.loadBlock = ^(CGRect bounds) {
      BOOL skip = YES;
      for(NSInteger y = weakTest.bounds.size.height; y >= 0; y -= 100)
      {
          NSInteger startx = skip ? 0 : 100;
          skip = !skip;
          for(NSInteger x = startx; x < weakTest.bounds.size.width; x += 200)
          {
              ColorBox* box = [[ColorBox alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
              box.backGroundColor = [VFColor randomBGColor:NO];
              box.circleColor = [VFColor randomBGColor:NO];
              [box setNeedsDisplayInRect:CGRectMake(x, y, 100, 100)];
              [weakTest addSubview:box];
          }
      }
    };
}

@end
 */
