//
//  TextTests.m
//  VexFlow
//
//  Created by Scott on 3/9/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "TextTests.h"
#import "VexFlowTestHelpers.h"

#import "VFFont.h"
#import "VFText.h"
#import "NSString+Ruby.h"

@implementation TextTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];

    [self runTest:@"Draw Text" func:@selector(drawText:)];
}



- (void)drawText:(NSView*)parent
{
//    TestCollectionItemView* test =
//        self.currentCell;   // VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(850, 1200) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

        // CGContextRef ctx = context.CGContext;
        // draw an outline of the frame
        //        NSBezierPath *outline = [NSBezierPath bezierPathWithRect:CGRectMake(bounds.origin.x,
        //                                                                            bounds.origin.y,
        //                                                                            bounds.size.width,
        //                                                                            bounds.size.height)];
        //        [outline setLineWidth:1.0];
        //        [SHEET_MUSIC_COLOR setFill];
        //        [VFColor.blackColor setStroke];
        //        [outline fill];
        //        [outline setLineWidth:3.0];
        //        [outline stroke];

        //      [VFTestView background:bounds];

//        [VFText drawSimpleText:ctx atPoint:VFPointMake(0, 0) withBounds:bounds withText:@"Hello core text world!"];
//        [VFText drawSimpleText:ctx atPoint:VFPointMake(30, 30) withBounds:bounds withText:@"Hello core text world!"];
//        [VFText drawSimpleText:ctx atPoint:VFPointMake(60, 60) withBounds:bounds withText:@"Hello core text world!"];
//        [VFText drawSimpleText:ctx atPoint:VFPointMake(0, 100) withBounds:bounds withText:@"Hello core text world!"];

        LoremIpsum* loremIpsum = [[LoremIpsum alloc] init];
        float x = 20;
        float y = 200;
        NSString* text = [NSString stringWithFormat:@"font count: %lu", (unsigned long)VFFont.fontNames.count];
        VFBoundingBox* boundingBox = VFBoundingBoxMake(x, y, 500, 30);
        [VFText drawTextWithContext:ctx
                            atPoint:VFPointMake(0, 0)
                         withBounds:boundingBox
                           withText:text
                       withFontName:@"TimesNewRomanPS-ItalicMT"
                           fontSize:12];
        NSUInteger i = 0;
        for(NSString* fontName in VFFont.fontNames)
        {
            NSString* text = [loremIpsum words:3];
            text = [text concat:[NSString stringWithFormat:@" %lu", (unsigned long)i]];
            y += 15;
            VFBoundingBox* boundingBox = VFBoundingBoxMake(x, y, 400, 30);
            [VFText drawTextWithContext:ctx
                                atPoint:VFPointMake(0, 0)
                             withBounds:boundingBox
                               withText:text
                           withFontName:fontName
                               fontSize:12];
            if(y > 1150)
            {
                x += 200;
                y = 15;
                //                break;
            }
            ++i;
        }
    };
}

@end