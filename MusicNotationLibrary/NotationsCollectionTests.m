//
//  NotationsCollectionTests.m
//  MusicApp
//
//  Created by Scott on 8/11/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "NotationsCollectionTests.h"

#import "NotationsGridTests.h"
#import "VexFlowTestHelpers.h"
#import "VFVexCore.h"
#import "GlyphLayer.h"

//@interface NotationsGrid ()
//
////@property (strong, nonatomic) NSMutableArray* glyphLayers;
//
//@end
//
//@interface NotationsViewController : NSViewController <NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout>
//
//@property (strong, nonatomic) NSMutableArray* glyphLayerObjects;
//
//@end
//
//@implementation NotationsViewController
//
//#pragma mark - <NSCollectionViewDataSource>
//
//- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView*)collectionView
//{
//    return 1;
//}
//
//- (NSInteger)collectionView:(NSCollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.glyphLayerObjects.count;
//}
//
//@end
//
//@class TestViewController;
//
//@interface NotationsWrappedLayout : NSCollectionViewFlowLayout
//
//@property (strong, nonatomic) TestViewController* testViewController;
//
//@end
//
////#define SLIDE_WIDTH \
////700.0   // width  of the SlideCarrier image (which includes shadow margins) in points, and thus the width  that we
////// give to a Slide's root view
////#define SLIDE_HEIGHT \
////150.0   // height of the SlideCarrier image (which includes shadow margins) in points, and thus the height that we
////// give to a Slide's root view
////
////#define SLIDE_SHADOW_MARGIN \
////10.0   // margin on each side between the actual slide shape edge and the edge of the SlideCarrier image
////#define SLIDE_CORNER_RADIUS 8.0   // corner radius of the slide shape in points
////#define SLIDE_BORDER_WIDTH 4.0    // thickness of border when shown, in points
////
////#define X_PADDING 10.0
////#define Y_PADDING 10.0
//
//@implementation NotationsWrappedLayout
//
//- (instancetype)init
//{
//    self = [super init];
//    if(self)
//    {
//        //        [self setItemSize:NSMakeSize(SLIDE_WIDTH, SLIDE_HEIGHT)];
//        //        [self setMinimumInteritemSpacing:X_PADDING];
//        //        [self setMinimumLineSpacing:Y_PADDING];
//        //        [self setSectionInset:NSEdgeInsetsMake(Y_PADDING, X_PADDING, Y_PADDING, X_PADDING)];
//    }
//    return self;
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(NSRect)newBounds
//{
//    return YES;
//}
//
//- (NSCollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath
//{
//    NSCollectionViewLayoutAttributes* attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
//    //    [attributes setZIndex:[indexPath item]];
//    //    attributes.frame = [self.testViewController frameAtIndex:indexPath.item];
//    return attributes;
//}
//
//- (NSArray*)layoutAttributesForElementsInRect:(NSRect)rect
//{
//    NSArray* layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
//    for(NSCollectionViewLayoutAttributes* attributes in layoutAttributesArray)
//    {
//        //        [attributes setZIndex:[[attributes indexPath] item]];
//        //        attributes.frame = [self.testViewController frameAtIndex:attributes.indexPath.item];
//        //
//    }
//    return layoutAttributesArray;
//}
//
//@end
//
@implementation NotationsCollectionTests
//
//- (void)start   //:(VFTestView*)parent;
//{
//    //    [super start:parent];
//    //    id targetClass = [self class];
//
//    [super start];
//
//    /*
//    self.testViewController = [[clazz alloc] init];
//    [self.testViewController start];
//    _collectionView.delegate = self.testViewController;
//    _collectionView.dataSource = self.testViewController;
//    //            ((NSScrollView*)_collectionView.superview).allowsMagnification = YES;
//
//    WrappedLayout* layout = [[WrappedLayout alloc] init];
//    layout.collectionView.delegate = self;
//    layout.testViewController = self.testViewController;
//    _collectionView.collectionViewLayout = layout;
//     */
//
//    //    _glyphLayers = [NSMutableArray array];
//
//    [self runTest:@"Grid" func:@selector(grid:drawBoundingBox:) frame:CGRectMake(0, 0, 1000, 1800) params:@(NO)];
//    //    [self runTest:@"Grid" func:@selector(grid:drawBoundingBox:) params:@(YES)];
//}
//
//- (TestTuple*)grid:(TestCollectionItemView*)parent drawBoundingBox:(NSNumber*)drawBoundingBox
//{
//    TestTuple* ret = [TestTuple testTuple];
//
//    BOOL shouldDrawBoundingBox = drawBoundingBox.boolValue;
//    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(850, 1300)
//    // withParent:parent];
//    //    test.backgroundColor = [VFTestView randomBGColor];
//    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    //    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    //        CGContextRef ctx = VFGraphicsContext();
//    // CGContextRef ctx = context.CGContext;
//    // draw an outline of the frame
//    // [[self class] background:dirtyRect];
//
//    // write the text at the top
//    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = kCTTextAlignmentLeft;
//
//    // http://iosfonts.com/
//    // Programming iOS 6, 3rd Edition, Attributed Strings
//    // http://goo.gl/CSmaQe
//
//    //        if(NSIntersectsRect(dirtyRect, CGRectMake(5, 5, bounds.size.width, 200)))
//    //        {
//    VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:25];
//    NSString* titleMessage = @"Vex Glyphs";
//    NSAttributedString* title = [[NSAttributedString alloc]
//        initWithString:titleMessage
//            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
//    [title drawInRect:CGRectMake(5, 5, parent.bounds.size.width, 200)];
//
//    NSTextField* textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(parent.bounds), 5, 0, 0)];
//    textLabel.editable = NO;
//    textLabel.selectable = NO;
//    textLabel.bordered = NO;
//    textLabel.drawsBackground = YES;   // NO;
//    //          textLabel.stringValue = description.string; // ?: @"";
//    textLabel.attributedStringValue = title;
//    [textLabel sizeToFit];
//    CGRect frame = textLabel.frame;
//    frame.origin.x -= CGRectGetWidth(frame) / 2;
//    textLabel.frame = frame;
//    dispatch_async(dispatch_get_main_queue(), ^{
//      [parent addSubview:textLabel];
//    });
//
//    //        }
//
//    //        if(NSIntersectsRect(dirtyRect, CGRectMake(5, 35, bounds.size.width, 200)))
//    //        {
//    VFFont* font2 = [VFFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15];
//    NSString* subTitleMessage = @"Cross indicates render coordinates.";
//    NSAttributedString* subtitle = [[NSAttributedString alloc]
//        initWithString:subTitleMessage
//            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font2}];
//    [subtitle drawInRect:CGRectMake(5, 35, parent.bounds.size.width, 200)];
//    //        }
//
//    textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(parent.bounds), 35, 0, 0)];
//    textLabel.editable = NO;
//    textLabel.selectable = YES;
//    textLabel.bordered = NO;
//    textLabel.drawsBackground = NO;
//    //          textLabel.stringValue = description.string; // ?: @"";
//    textLabel.attributedStringValue = subtitle;
//    [textLabel sizeToFit];
//    frame = textLabel.frame;
//    frame.origin.x -= CGRectGetWidth(frame) / 2;
//    textLabel.frame = frame;
//    dispatch_async(dispatch_get_main_queue(), ^{
//      [parent addSubview:textLabel];
//    });
//
//    // TODO: do the following lines do anything?
//    //    VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:15];
//    //    subTitleMessage = @"";
//    //    __block NSAttributedString* description = [[NSAttributedString alloc]
//    //        initWithString:subTitleMessage
//    //            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : descriptionFont}];
//
//    //      CGContextSetLineWidth(ctx, 1.0f);
//
//    __block NSUInteger y = 70;
//    __block NSUInteger x = 0;
//    __block NSUInteger symbolsAcross = 10;
//    NSArray* glyphStructArray = [VFGlyphList sharedInstance].availableGlyphStructsArray;
//    [glyphStructArray enumerateObjectsUsingBlock:^(VFGlyphStruct* g, NSUInteger idx, BOOL* stop) {
//      if(idx % symbolsAcross == 0)
//      {
//          x = 30;
//          y += 80;
//      }
//      x += 90;
//
//      CGPoint crossPoint = CGPointMake(x, y);
//
//      //          if(!NSIntersectsRect(dirtyRect, CGRectMake(x - 5, y - 5, x + 5, y + 5)))
//      //          {
//      //              return;
//      //          }
//
//      [VFColor.blackColor setStroke];
//
//      //        CGContextMoveToPoint(ctx, x - 5, y);
//      //        CGContextAddLineToPoint(ctx, x + 5, y);
//      //        CGContextStrokePath(ctx);
//
//      //        CGContextMoveToPoint(ctx, x, y - 5);
//      //        CGContextAddLineToPoint(ctx, x, y + 5);
//      //        CGContextStrokePath(ctx);
//
//      CAShapeLayer* crossLayer = [CAShapeLayer layer];
//      CGPathRef immutablePath = NULL;
//      CGMutablePathRef mutablePath = CGPathCreateMutable();
//      CGPathMoveToPoint(mutablePath, NULL, x - 5, y);
//      CGPathAddLineToPoint(mutablePath, NULL, x + 5, y);
//      CGPathMoveToPoint(mutablePath, NULL, x, y - 5);
//      CGPathAddLineToPoint(mutablePath, NULL, x, y + 5);
//      CGPathCloseSubpath(mutablePath);
//      immutablePath = CGPathCreateCopy(mutablePath);
//      CGPathRelease(mutablePath);
//      crossLayer.path = immutablePath;
//      crossLayer.lineCap = kCALineCapRound;
//      crossLayer.lineWidth = 1;
//      crossLayer.strokeColor = [VFColor blackColor].CGColor;
//      crossLayer.fillColor = [VFColor blackColor].CGColor;
//      crossLayer.zPosition = +3;
//      dispatch_async(dispatch_get_main_queue(), ^{
//        [parent.layer addSublayer:crossLayer];
//      });
//
//      //        [description drawAtPoint:CGPointMake(x - 25, y - 10)];
//
//      // write the name of the glyph
//      NSTextField* textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(x - 35, y - 10, 0, 0)];
//      textLabel.editable = NO;
//      textLabel.selectable = YES;
//      textLabel.bordered = NO;
//      textLabel.drawsBackground = NO;
//      textLabel.attributedStringValue = [[NSAttributedString alloc] initWithString:g.name];
//      [textLabel sizeToFit];
//      dispatch_async(dispatch_get_main_queue(), ^{
//        [parent addSubview:textLabel];
//      });
//
//#define GLYPH_SCALE 1.4
//
//      GlyphShapeLayer* glyphLayer = [GlyphShapeLayer layer];
//      glyphLayer.borderWidth = 1.0;
//      glyphLayer.borderColor = [NSColor orangeColor].CGColor;
//      glyphLayer.backgroundColor = [NSColor lightGrayColor].CGColor;
//
//      CGSize size = CGScaleSize(g.size, GLYPH_SCALE);
//      glyphLayer.frame = CGPointSizeCombine(
//          crossPoint, size);   // CGRectExpandBySize(CGPointSizeCombine(crossPoint, size), CGSizeMake(10, 10));
//      glyphLayer.position = crossPoint;
//      CGPoint pt = glyphLayer.anchorPoint = CGClampPoint(CGInvertPoint(g.anchorPoint.CGPoint), g.size);
//
//      NSLog(@"%.02f, %.02f", pt.x, pt.y);
//
//      glyphLayer.fillColor = VFColor.blackColor.CGColor;   //[VFColor randomBGColor:NO].CGColor;
//      CGPoint point = CGPointZero;
//      CGPathRef cgpath = [VFGlyph createPathwithCode:g.name
//                                           withScale:GLYPH_SCALE
//                                             atPoint:CGScalePoint(CGInvertPoint(g.anchorPoint.CGPoint), GLYPH_SCALE)];
//      glyphLayer.path = cgpath;
//      // CGPointMake(x, y);
//      //            glyphLayer.position = CGPointMake(-g.anchorPoint.CGPoint.x + x, g.anchorPoint.CGPoint.y + y);
//      //        glyphLayer.position = crossPoint; //CGCombinePoints(CGScalePoint(g.anchorPoint.CGPoint, GLYPH_SCALE),
//      //        crossPoint);
//      //      glyphLayer.position = CGPointMake(g.size.width + x, -g.size.height + y);
//      // CGPointMake(0.5, 0.5); //CGPointZero;
//      //            glyphLayer.anchorPoint = CGPointMake(0.5, 0.5); //CGPointZero;
//      //        glyphLayer.anchorPoint = CGPointMake(0.0, 1.0);
//
//      glyphLayer.zPosition = +1;
//      dispatch_async(dispatch_get_main_queue(), ^{
//        [parent.layer addSublayer:glyphLayer];
//      });
//    }];
//
//    //    GlyphShapeLayer* glyphLayer = [GlyphShapeLayer layer];
//    //    glyphLayer.frame = CGRectMake(0, 0, 100, 100);
//    //    glyphLayer.position = CGPointMake(200, 200);
//    //    glyphLayer.fillColor = [NSColor redColor].CGColor;   // VFColor.blackColor.CGColor;
//    //    CGPathRef immutablePath = NULL;
//    //    CGMutablePathRef mutablePath = CGPathCreateMutable();
//    //    CGPathAddRect(mutablePath, NULL, CGRectMake(0, 0, 100, 100));
//    //    CGPathCloseSubpath(mutablePath);
//    //    immutablePath = CGPathCreateCopy(mutablePath);
//    //    CGPathRelease(mutablePath);
//    //    glyphLayer.path = immutablePath;
//    //    //    glyphLayer.position = CGPointMake(100, 100);.
//    //    glyphLayer.zPosition = +5;
//    //    dispatch_async(dispatch_get_main_queue(), ^{
//    //      [parent.layer addSublayer:glyphLayer];
//    //    });
//
//    //    };
//    return nil;
//}
//
//- (void)mouseDown:(NSEvent*)theEvent
//{
//    //    NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
//}

@end
