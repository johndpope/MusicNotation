//
//  NotationsGrid.m
//  VexFlow
//
//  Created by Scott on 3/9/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "NotationsGridTests.h"
#import "VexFlowTestHelpers.h"
#import "VFVexCore.h"
#import "GlyphLayer.h"
#import "CarrierLayer.h"

@interface NotationsGridTests ()

//@property (strong, nonatomic) NSMutableArray* glyphLayers;

@end

@implementation NotationsGridTests

- (void)start
{
    [super start];

    //    _glyphLayers = [NSMutableArray array];
    [self runTest:@"Grid" func:@selector(grid:drawBoundingBox:) frame:CGRectMake(0, 0, 1000, 1900) params:@(NO)];
}

- (TestTuple*)grid:(TestCollectionItemView*)parent drawBoundingBox:(NSNumber*)drawBoundingBox
{
    //    TestTuple* ret = [TestTuple testTuple];

    BOOL shouldDrawBoundingBox = drawBoundingBox.boolValue;

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentLeft;

    // http://iosfonts.com/
    // Programming iOS 6, 3rd Edition, Attributed Strings
    // http://goo.gl/CSmaQe

    VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25];
    NSString* titleMessage = @"Vex Glyphs";
    NSAttributedString* title = [[NSAttributedString alloc]
        initWithString:titleMessage
            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];

    NSTextField* textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(parent.bounds), 5, 0, 0)];
    textLabel.editable = NO;
    textLabel.selectable = NO;
    textLabel.bordered = NO;
    textLabel.drawsBackground = YES;
    textLabel.attributedStringValue = title;
    [textLabel sizeToFit];
    CGRect frame = textLabel.frame;
    frame.origin.x -= CGRectGetWidth(frame) / 2;
    textLabel.frame = frame;
    dispatch_async(dispatch_get_main_queue(), ^{
      [parent addSubview:textLabel];
    });

    VFFont* font2 = [VFFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15];
    NSString* subTitleMessage = @"Cross indicates render coordinates.";
    NSAttributedString* subtitle = [[NSAttributedString alloc]
        initWithString:subTitleMessage
            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font2}];

    textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(parent.bounds), 35, 0, 0)];
    textLabel.editable = NO;
    textLabel.selectable = YES;
    textLabel.bordered = NO;
    textLabel.drawsBackground = NO;
    //          textLabel.stringValue = description.string; // ?: @"";
    textLabel.attributedStringValue = subtitle;
    [textLabel sizeToFit];
    frame = textLabel.frame;
    frame.origin.x -= CGRectGetWidth(frame) / 2;
    textLabel.frame = frame;
    dispatch_async(dispatch_get_main_queue(), ^{
      [parent addSubview:textLabel];
    });

    __block NSUInteger y = 70;
    __block NSUInteger x = 0;
    __block NSUInteger symbolsAcross = 10;

    NSArray* glyphStructArray = [VFGlyphList sharedInstance].availableGlyphStructsArray;
    NSMutableArray* subLayers = [NSMutableArray arrayWithCapacity:glyphStructArray.count];
    NSMutableArray* textLabels = [NSMutableArray arrayWithCapacity:glyphStructArray.count];
    CFAbsoluteTime then = CFAbsoluteTimeGetCurrent();
    [glyphStructArray enumerateObjectsUsingBlock:^(VFGlyphStruct* g, NSUInteger idx, BOOL* stop) {
      if(idx % symbolsAcross == 0)
      {
          x = 30;
          y += 90;
      }
      x += 90;

      // label the glyph
      NSTextField* textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(x - 45, y - 10, 0, 0)];
      textLabel.editable = NO;
      textLabel.selectable = YES;
      textLabel.attributedStringValue = [[NSAttributedString alloc] initWithString:g.name];
      [textLabel sizeToFit];
      [textLabels addObject:textLabel];

#define GLYPH_SCALE 1.4
      CarrierLayer* carrierLayer =
          [VFGlyph createCarrierLayerWithCode:g.name withScale:GLYPH_SCALE hasCross:YES];   //[CarrierLayer layer];
      carrierLayer.position = CGPointMake(x, y);

      // alter the color of the glyph
      [((CAShapeLayer*)carrierLayer.sublayers[1])setFillColor:[VFColor crayolaRubyColor].CGColor];
      if(shouldDrawBoundingBox)
      {
          [((CAShapeLayer*)carrierLayer.sublayers[1])setBackgroundColor:[VFColor crayolaOrangeColor].CGColor];
      }

      [subLayers addObject:carrierLayer];
    }];

    // calculate how long it took
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    CFTimeInterval elapsed = now - then;
    textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(parent.bounds) - 160, 15, 0, 0)];
    textLabel.editable = NO;
    textLabel.selectable = NO;
    textLabel.bordered = YES;
    textLabel.drawsBackground = YES;
    textLabel.stringValue = [NSString stringWithFormat:@"elapsed: %.03f (ms)", elapsed * 1000];
    [textLabel sizeToFit];
    frame = textLabel.frame;
    textLabel.frame = frame;

    // add all the stuff to the parent view
    dispatch_async(dispatch_get_main_queue(), ^{
      for(CALayer* layer in subLayers)
      {
          [parent.layer addSublayer:layer];
      }
      for(NSTextField* textLabel in textLabels)
      {
          [parent addSubview:textLabel];
      }
      [parent addSubview:textLabel];
    });

    return nil;
}

- (void)mouseDown:(NSEvent*)theEvent
{
    //    NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
}

@end
