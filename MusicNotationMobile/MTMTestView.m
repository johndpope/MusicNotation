////
////  MTMTestView.m
////  MusicApp
////
////  Created by Scott on 8/3/15.
////  Copyright © 2015 feedbacksoftware.com. All rights reserved.
////
//
//#import "MTMTestView.h"
//#import "VFBezierPath.h"
//#import "VFColor.h"
//
////@implementation ViewStaffStruct
////+ (ViewStaffStruct*)contextWithStaff:(VFStaff*)staff andView:(MTMTestView*)testView;
////{
////    ViewStaffStruct* ret = [[ViewStaffStruct alloc] init];
////    ret.staff = staff;
////    ret.view = testView;
////    return ret;
////}
////@end
//
//
//@interface MTMTestView ()
//@property (strong, nonatomic) NSMutableArray* handlers;
//@property (assign, nonatomic) BOOL loaded;
//@end
//
//@implementation MTMTestView
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if(self)
//    {
//        self.backgroundColor = (VFColor*)VFColor.greenColor;
//    }
//    return self;
//}
//
//- (BOOL)isFlipped
//{
//    return NO;
//}
//
//- (void)viewWillDraw
//{
//    if(!self.loaded)
//    {
//        self.loaded = YES;
//        if(self.loadBlock)
//        {
//            self.loadBlock(self.bounds);
//        }
//    }
//}
//
//- (void)drawRect:(CGRect)dirtyRect
//{
//    [super drawRect:dirtyRect];
////    if([self needsToDrawRect:dirtyRect])
////    {
//        // for debugging
//        //        self.backgroundColor = [VFColor randomBGColor:YES];
//        
//        [self.backgroundColor set];
//        
////        NSRectFill(dirtyRect);
//        [super drawRect:dirtyRect];
//    
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        for(DrawBlock drawBlock in self.handlers)
//        {
//            CGContextSaveGState(ctx);
//            if(drawBlock)
//            {
//                drawBlock(dirtyRect, self.bounds, ctx);
//            }
//            
//            CGContextRestoreGState(ctx);
//        }
//        
//        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.alignment = kCTTextAlignmentLeft;
//        UIFont* font1 = [UIFont fontWithName:@"Helvetica" size:12];
//        
//        NSAttributedString* titleString = [[NSAttributedString alloc]
//                                           initWithString:self.title
//                                           attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
//        //    [title drawInRect:CGRectMake(self.x, y - 3, 50, 100)];
//        [titleString drawAtPoint:CGPointMake(10, 10)];
//        
//        NSLog(@"VFTestView redraw DrawBlock %f %f %f %f", dirtyRect.origin.x, dirtyRect.origin.y, dirtyRect.size.width,
//              dirtyRect.size.height);
////    }
//}
//
////- (BOOL)wantsUpdateLayer
////{
////    return YES;
////}
//
////- (void)updateLayer
////{
////    CALayer* layer = self.layer;
////    layer.backgroundColor = [NSColor greenColor].CGColor;
////}
//
////- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx
////{
////    layer.backgroundColor = [NSColor greenColor].CGColor;
////    [[NSColor clearColor] set];
////    NSRectFill(self.bounds);
////
////    NSGraphicsContext* context = [NSGraphicsContext currentContext];
////    //    [context saveGraphicsState];
////    //    if (self.drawBlock) {
////    //        self.drawBlock(dirtyRect, self.bounds, context);
////    //    }
////    //    [context restoreGraphicsState];
////    for(DrawBlock drawBlock in self.handlers)
////    {
////        [context saveGraphicsState];
////        drawBlock(self.bounds, self.bounds, context);
////        [context restoreGraphicsState];
////    }
////
////    NSLog(@"redraw");
////}
//
//+ (void)background:(CGRect)bounds;
//{
//    CGRect rect = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
//    VFBezierPath* outline = [VFBezierPath bezierPathWithRect:rect];
//    //    [SHEET_MUSIC_COLOR setFill];
//    [[VFColor randomBGColor:YES] setFill];
//    [outline fill];
//    //    [outline setLineWidth:1.0];
//    //    [VFColor.blackColor setStroke];
//    //    [outline setLineWidth:3.0];
//    //    [outline stroke];
//}
//
//- (NSMutableArray*)handlers
//{
//    if(!_handlers)
//    {
//        _handlers = [NSMutableArray array];
//    }
//    return _handlers;
//}
//
//- (void)setDrawBlock:(DrawBlock)drawBlock
//{
//    //    _drawBlock = drawBlock;
//    // TODO: decide to draw after each method call or at end of start
//    [self.handlers addObject:drawBlock];
//    //    [self setNeedsDisplay:YES];
//}
//
//+ (void)start:(UIView*)parent;
//{
//    // any additional setup...
//}
//
//+ (MTMTestView*)createCanvasTest:(CGSize)size withParent:(UIView*)parent;
//{
//    MTMTestView* test = [[MTMTestView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    [parent addSubview:test];
//    test.translatesAutoresizingMaskIntoConstraints = YES;
////    [test setNeedsDisplay:YES];
//    return test;
//}
//
//+ (MTMTestView*)createCanvasTest:(CGSize)size withParent:(UIView*)parent withTitle:(NSString*)title;
//{
//    MTMTestView* test = [[MTMTestView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    [parent addSubview:test];
//    test.title = title;
//    test.translatesAutoresizingMaskIntoConstraints = YES;
//    //    [test setNeedsDisplay:YES];
//    
//    return test;
//}
//
//+ (MTMTestView*)createCanvasWithOutAdding:(CGSize)size withParent:(UIView*)parent withTitle:(NSString*)title;
//{
//    MTMTestView* test = [[MTMTestView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    test.title = title;
//    test.translatesAutoresizingMaskIntoConstraints = YES;
//    return test;
//}
//
//@end