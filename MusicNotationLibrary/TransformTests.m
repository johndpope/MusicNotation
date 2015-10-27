//
//  TransformTests.m
//  VexFlow
//
//  Created by Scott on 5/16/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "TransformTests.h"
#import "VexFlowTestHelpers.h"

@interface GlyphBox : NSObject
@end
@implementation GlyphBox
- (void)drawLayer:(CALayer*)theLayer inContext:(CGContextRef)ctx
{
    NSLog(@"GlyphBox drawLayer");

    CGPoint center;
    center.x = CGRectGetMidX(theLayer.bounds);
    center.y = CGRectGetMidY(theLayer.bounds);

    CGContextSaveGState(ctx);

    [VFColor.blackColor setFill];
    VFGlyphStruct* trebleGlyph = [VFGlyphList sharedInstance].availableGlyphStructsDictionary[@"v3d"];
    [VFGlyph renderGlyph:ctx
                      atX:center.x - 30
                      atY:center.y
                withScale:2
             forGlyphCode:trebleGlyph.name
        renderBoundingBox:NO];

    CGContextRestoreGState(ctx);
}
@end
/*
@interface TransformTests ()
@property (strong, nonatomic) GlyphBox* boxDelegate;
@property (strong, nonatomic) CALayer* box;
@property (strong, nonatomic) GlyphBox* boxDelegate2;
@property (strong, nonatomic) CALayer* box2;
+ (TransformTests*)createCanvasTest:(CGSize)size withParent:(VFTestView*)parent;
@end

@implementation TransformTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    //    for(NSUInteger i = 0; i < 5; ++i)
    //    {
    [self runTest:@"Draw"  func:@selector(draw:)];
    //    }
    [self runTest:@"Draw2"  func:@selector(draw2:)];
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    [super drawRect:dirtyRect];
//    // do any additional drawing ...
//    NSLog(@"TransformTests drawRect");
//}

//- (void)viewWillDraw
//{
//    NSLog(@"TransformTests viewWillDraw");
//}

//- (void)drawLayer:(CALayer*)theLayer inContext:(CGContextRef)ctx
//{
//    NSLog(@"TransformTests drawLayer");
//}

//- (void)displayLayer:(CALayer *)layer
//{
//    NSLog(@"displayLayer");
//}

+ (TransformTests*)createCanvasTest:(CGSize)size withParent:(VFTestView*)parent;
{
    TransformTests* test = [[TransformTests alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    // [parent addSubview:test];
    test.translatesAutoresizingMaskIntoConstraints = YES;
    [test setNeedsDisplay:YES];
    return test;
}

- (void)draw:(VFTestView*)parent
{
    TransformTests* test = [[self class] createCanvasTest:CGSizeMake(700, 300) withParent:parent];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    test.wantsLayer = YES;
    CALayer* layer = [CALayer layer];
    layer.frame = test.frame;
    test.layer.opacity = 1.0;
    layer.backgroundColor = [VFColor randomBGColor:YES].CGColor;
    [test setLayer:layer];
    test.backgroundColor = [VFColor randomBGColor:NO];
    layer.delegate = test;
    //    [test.layer setNeedsDisplay:YES];
    [test.layer setNeedsDisplay];

    test.box = [CALayer layer];
    test.box.opacity = 1.0;
    test.box.backgroundColor = [NSColor redColor].CGColor;   //[VFColor randomBGColor:NO].CGColor;
    test.box.bounds = CGRectMake(0, 0, 100, 150);
    test.box.position = CGPointMake(100, 100);   // 100, CGRectGetMidY(test.frame));
    test.boxDelegate = [[GlyphBox alloc] init];
    test.box.delegate = test.boxDelegate;
    [test.layer addSublayer:test.box];
    test.box.transform = CATransform3DMakeRotation(90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
    [test.box setNeedsDisplay];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // draw an outline of the frame
      // [[self class] background:dirtyRect];

      // write the text at the top
      NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
      paragraphStyle.alignment = kCTTextAlignmentCenter;

      // http://iosfonts.com/
      // Programming iOS 6, 3rd Edition, Attributed Strings
      // http://goo.gl/CSmaQe

      if(NSIntersectsRect(dirtyRect, CGRectMake(5, 5, bounds.size.width, 200)))
      {
          VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:15];
          NSString* titleMessage = @"Transform Test";
          NSAttributedString* title = [[NSAttributedString alloc]
              initWithString:titleMessage
                  attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
          [title drawInRect:CGRectMake(5, 5, bounds.size.width, 200)];
      }

      // TODO: do the following lines do anything?
//      VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:15];
//      NSString* subTitleMessage = @"";
//      __block NSAttributedString* description = [[NSAttributedString alloc]
//          initWithString:subTitleMessage
//              attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : descriptionFont}];

      CGContextSetLineWidth(ctx, 1.0f);

      VFGlyphStruct* trebleGlyph = [VFGlyphList sharedInstance].availableGlyphStructsDictionary[@"v3d"];

      // render the glyph

      // TODO: render by passing glyph struct

      NSUInteger x = 50;
      NSUInteger shift = 50;
      NSUInteger y = 200;
      float scale = 1;
      BOOL drawBB = YES;
      for(NSUInteger i = 0; i < 7; ++i)
      {
          //          VFColor* color = VFColor.blackColor;
          //              (VFColor*)[VFColor randomBGColor:YES];
          [VFColor.blackColor setFill];
          //          [VFColor.blackColor setStroke];
          [VFGlyph renderGlyph:ctx atX:x atY:y withScale:scale forGlyphCode:trebleGlyph.name renderBoundingBox:drawBB];
          scale *= 1.2;
          x += (shift *= 1.2);
          drawBB = !drawBB;
      }


    };
}

- (void)draw2:(VFTestView*)parent
{
    TransformTests* test = [[self class] createCanvasTest:CGSizeMake(700, 350) withParent:parent];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    test.wantsLayer = YES;
    CALayer* layer = [CALayer layer];
    layer.frame = test.frame;
    test.layer.opacity = 1.0;
    layer.backgroundColor = [VFColor randomBGColor:YES].CGColor;
    [test setLayer:layer];
    test.backgroundColor = [VFColor randomBGColor:NO];
    layer.delegate = test;
    //    [test.layer setNeedsDisplay:YES];
    [test.layer setNeedsDisplay];

    test.box2 = [CALayer layer];
    test.box2.opacity = 1.0;
    test.box2.backgroundColor = [NSColor redColor].CGColor;   //[VFColor randomBGColor:NO].CGColor;
    test.box2.bounds = CGRectMake(0, 0, 100, 150);
    test.box2.position = CGPointMake(100, 100);   // 100, CGRectGetMidY(test.frame));
    test.boxDelegate2 = [[GlyphBox alloc] init];
    test.box2.delegate = test.boxDelegate2;
    [test.layer addSublayer:test.box2];
    test.box2.transform = CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0);
    [test.box2 setNeedsDisplay];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // draw an outline of the frame
      // [[self class] background:dirtyRect];

      // write the text at the top
      NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
      paragraphStyle.alignment = kCTTextAlignmentCenter;

      // http://iosfonts.com/
      // Programming iOS 6, 3rd Edition, Attributed Strings
      // http://goo.gl/CSmaQe

      if(NSIntersectsRect(dirtyRect, CGRectMake(5, 5, bounds.size.width, 200)))
      {
          VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:15];
          NSString* titleMessage = @"Transform Test";
          NSAttributedString* title = [[NSAttributedString alloc]
              initWithString:titleMessage
                  attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
          [title drawInRect:CGRectMake(5, 5, bounds.size.width, 200)];
      }

      // TODO: do the following lines do anything?
//      VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:15];
//      NSString* subTitleMessage = @"";
//      __block NSAttributedString* description = [[NSAttributedString alloc]
//          initWithString:subTitleMessage
//              attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : descriptionFont}];

      CGContextSetLineWidth(ctx, 1.0f);

      VFGlyphStruct* trebleGlyph = [VFGlyphList sharedInstance].availableGlyphStructsDictionary[@"v79"];

      // render the glyph

      // TODO: render by passing glyph struct

      NSUInteger x = 20;
      NSUInteger shift = 50;
      NSUInteger y = 200;
      float scale = 1;
      BOOL drawBB = YES;
      for(NSUInteger i = 0; i < 7; ++i)
      {
          //          VFColor* color = VFColor.blackColor;
          //              (VFColor*)[VFColor randomBGColor:YES];
          [VFColor.blackColor setFill];
          //          [VFColor.blackColor setStroke];
          [VFGlyph renderGlyph:ctx atX:x atY:y withScale:scale forGlyphCode:trebleGlyph.name renderBoundingBox:drawBB];
          scale *= 1.2;
          x += (shift *= 1.2);
          drawBB = !drawBB;
      }

    };
}

@end
 */
