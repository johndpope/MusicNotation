//
//  AnimationTest.m
//  VexFlow
//
//  Created by Scott on 4/17/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "AnimationTests.h"
#if TARGET_OS_IPHONE
//#import "MTMTestHelpers.h"
#elif TARGET_OS_MAC
#import "VexFlowTestHelpers.h"
#endif

#import "VFVexCore.h"
/*
@interface AnimationGlyphBox : NSObject
@end
@implementation AnimationGlyphBox
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

@implementation AnimationTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Basic"  func:@selector(basic:withTitle:)];
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//    [super drawRect:dirtyRect];
//
//    // Drawing code here.
//}

- (AnimationTests*)createCanvasTest:(CGSize)size withParent:(VFTestView*)parent withTitle:(NSString*)title
{
    AnimationTests* test = [[AnimationTests alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    test.title = title;
    // [parent addSubview:test];
    test.translatesAutoresizingMaskIntoConstraints = YES;
    [test setNeedsDisplay:YES];
    return test;
}

- (void)basic:(VFTestView*)parent withTitle:(NSString*)title
{
    AnimationTests* test = [[self class] createCanvasTest:CGSizeMake(700, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    test.wantsLayer = YES;
    CALayer* layer = [CALayer layer];
    layer.frame = test.frame;
    test.layer.opacity = 1.0;
    layer.backgroundColor = [VFColor randomBGColor:YES].CGColor;
    [test setLayer:layer];
    test.backgroundColor = [VFColor randomBGColor:NO];
    layer.delegate = test;
    [test.layer setNeedsDisplay];

    test.box = [CALayer layer];
    test.box.opacity = 1.0;
    test.box.backgroundColor = [NSColor redColor].CGColor;   //[VFColor randomBGColor:NO].CGColor;
    test.box.bounds = CGRectMake(0, 0, 100, 150);
    test.box.position = CGPointMake(100, 100);   // 100, CGRectGetMidY(test.frame));
    test.boxDelegate = [[AnimationGlyphBox alloc] init];
    test.box.delegate = test.boxDelegate;
    [test.layer addSublayer:test.box];
    test.box.transform = CATransform3DMakeRotation(0, 0, 0, 0);   // 90.0 / 180.0 * M_PI, 0.0, 0.0, 1.0);
    [test.box setNeedsDisplay];

    test.animateButton = [[VFButton alloc] init];
    [test.animateButton setButtonType:NSMomentaryPushInButton];
    [test.animateButton setBezelStyle:NSRoundedBezelStyle];
    [test.animateButton setTarget:self];
    test.animateButton.title = @"Animate";
    [test.animateButton sizeToFit];
    [test.animateButton setTarget:test];
    [test.animateButton setAction:@selector(animate:)];
    CGSize size = test.animateButton.frame.size;
    // TODO: button is incorrectly positioned
    //    test.animateButton.layer.position = CGPointMake(250, 250);
    test.animateButton.layer.frame = NSRectFromCGRect(CGRectMake(100, 350, size.width, size.height));
    test.animateButton.wantsLayer = YES;
    test.animateButton.layer.backgroundColor = [NSColor redColor].CGColor;
    [test addSubview:test.animateButton];
    //    test.animateButton.layer.position=NSMakePoint(0, 80.);
    //    [test.layer addSublayer:test.animateButton.layer];

    //    NSView* aView = [[NSView alloc]initWithFrame:CGRectMake(150, 150, 100, 100)];
    //    aView.wantsLayer = YES;
    //    aView.layer.backgroundColor = [NSColor blueColor].CGColor;
    //// either of the following add this view to the test view
    ////    [test addSubview:aView];
    ////    [test.layer addSublayer:aView.layer];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      //      // [[self class] background:dirtyRect];
      //
      // write the text at the top
      NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
      paragraphStyle.alignment = kCTTextAlignmentCenter;

      // http://iosfonts.com/
      // Programming iOS 6, 3rd Edition, Attributed Strings
      // http://goo.gl/CSmaQe

      if(NSIntersectsRect(dirtyRect, CGRectMake(5, 5, bounds.size.width, 200)))
      {
          VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25];
          NSString* titleMessage = @"Animation Test";
          NSAttributedString* title = [[NSAttributedString alloc]
              initWithString:titleMessage
                  attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
          [title drawInRect:CGRectMake(5, 5, bounds.size.width, 200)];
      }

      //      // TODO: do the following lines do anything?
      //      VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:15];
      //      NSString* subTitleMessage = @"";
      //      __block NSAttributedString* description = [[NSAttributedString alloc]
      //          initWithString:subTitleMessager
      //              attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName :
      //              descriptionFont}];
      //
      //      CGContextSetLineWidth(ctx, 1.0f);

      VFGlyphStruct* trebleGlyph = [VFGlyphList sharedInstance].availableGlyphStructsDictionary[@"v7a"];

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

- (IBAction)animate:(VFButton*)sender
{
    [sender setEnabled:NO];

    NSLog(@"animation begin");

    CGFloat translationX = 100;
    CGPoint finalPosition =
        CGPointMake(translationX, self.box.position.y);   // self.box.position.x + translationX, self.box.position.y);

    [CATransaction begin];
    {
        [CATransaction setCompletionBlock:^{
          self.box.position = finalPosition;
          self.box.transform = CATransform3DMakeRotation(0, 0, 0, 0);
          [sender setEnabled:YES];
          NSLog(@"animation complete");
        }];

        // spin
        CABasicAnimation* myAnimation = [CABasicAnimation animation];
        myAnimation.removedOnCompletion = YES;
        myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        myAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        myAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        myAnimation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
        myAnimation.duration = 1.0;
        myAnimation.repeatCount = 1.0;   // HUGE_VALF;
        [self.box addAnimation:myAnimation forKey:@"testAnimation"];

        // translate
        CABasicAnimation* myAnimation2 = [CABasicAnimation animation];
        myAnimation2.removedOnCompletion = YES;
        myAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
        myAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        myAnimation2.fromValue = [NSNumber numberWithFloat:0.0];
        myAnimation2.toValue = [NSNumber numberWithFloat:500];
        myAnimation2.duration = 1.0;
        myAnimation2.repeatCount = 1.0;
        [self.box addAnimation:myAnimation2 forKey:@"testAnimation2"];
    }
    [CATransaction commit];
}

@end
 */
