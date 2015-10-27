//
//  VFSymbol.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
@import Foundation;
#elif TARGET_OS_MAC
@import AppKit;
#endif

#import "VFColor.h"
#import "VFBezierPath.h"
#import "VFSymbol.h"
#import "VFVex.h"
#import "VFPoint.h"
#import "VFGlyphList.h"
//#import "VFVexCore.h"
#import "VFRenderOptions.h"
#import <objc/runtime.h>
#import "VFGlyphList.h"
#import "NSString+Ruby.h"
#import "VFMetrics.h"
#import "VFBoundingBox.h"
#import "VFShapeLayer.h"

@interface VFSymbol ()   //<CALayerDelegate> // <-- informal protocol

@end

@implementation VFSymbol
#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (instancetype)node
{
    return [[VFSymbol alloc] initWithDictionary:nil];
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        //[NSException raise:NSStringFromClass([self class])
        //          format:@"Attempting to instantiate an abstract class. Use a concrete subclass instead."];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setupSymbol];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithCode:(NSString*)code
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.symbolMetrics.code = code;
        [self setupSymbol];
        //        [self load];
    }
    return self;
}

- (instancetype)initWithCode:(NSString*)code withPointSize:(float)pointSize
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.symbolMetrics.code = code;
        //        self.symbolMetrics.point = point;
        [self setupSymbol];
        //        [self load];
    }
    return self;
}

//- (instancetype)initWithCode:(NSString *)code
//           atPoint:(VFPoint *)point {
////          withSize:(CGSize)size{
//    self = [super init];
//    if (self) {
//        [self setup];
//        self.metrics.code = code;
//        self.metrics.point = point;
////        self.metrics.bounds
//    }
//    return self;
//}

+ (VFSymbol*)symbol
{
    return [[VFSymbol alloc] init];
}

+ (VFSymbol*)symbolWithCode:(NSString*)code withPointSize:(float)pointSize
{
    return [[VFSymbol alloc] initWithCode:code withPointSize:pointSize];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setupSymbol
{
    //    if (self.metrics.code) {
    //        self.category = [VFGlyphList nameForCode:self.metrics.code];
    //    }
    _preFormatted = NO;
    _postFormatted = NO;

    _skewX = _skewY = 0.0f;
    _rotationalSkewX = _rotationalSkewY = 0.0f;
    _scaleX = _scaleY = 1.0f;

    _isTransformDirty = _isInverseDirty = YES;

    _vertexZ = 0;

    _visible = YES;

    _zOrder = 0;

    // children (lazy allocs)
    _children = nil;

    // userObject is always inited as nil
    _userObject = nil;

    // initialize parent to nil
    _parent = nil;

    _orderOfArrival = 0;

    _cascadeOpacityEnabled = NO;
    _cascadeColorEnabled = NO;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------Ø
 */
//- (NSString*)description
//{
//    //    NSString *ret = [self prolog];
//    //
//    //    ret = [ret concat:[NSString stringWithFormat:@"Category: %@\n", self.category]];
//    //    ret = [ret concat:[self.metrics prettyPrint]];
//
//    return [NSString stringWithFormat:@"<%@ = %p | Name = %@>", [self class], self, _name];
//
//    //    return [VFLog FormatObject:[self epilog:ret]];
//}
//- (NSString*)prolog
//{
//    //    static int depth = 0;
//    //    int i = depth++;
//    //    id a = self;
//    //    while (i > 0) {
//    //        a = class_getSuperclass([a class]);
//    //        --i;
//    //    }
//    //
//    //    const char *str = class_getName([a class]);
//
//    //    NSString *desc = [desc concat:[NSString stringWithFormat:@"%s <%p> : { \n", str, self]];
//
//    NSString* desc = [NSString stringWithFormat:@"%@ { \n", @""];
//
//    //    NSString *desc = [NSString stringWithFormat:@"%@ { \n", @"super : "];
//
//    //    NSString *desc = [NSString stringWithCString:str encoding:NSASCIIStringEncoding];
//    //***
//    //    desc = [desc concat:[NSString stringWithFormat:@"%s { \n", str]];
//    return desc;
//}
//
//- (NSString*)epilog:(NSString*)desc
//{
//    desc = [desc concat:@"}\n"];
//    return desc;
//}

/*!
 *  hhelps create a debug description from the specified string to properties dictionary
 *  @return a dictionary of property names
 */
- (NSDictionary*)dictionarySerialization;
{
    //    return [self dictionaryWithValuesForKeyPaths:@[]];
    return [self dictionaryWithValuesForKeyPaths:@[]];
}

- (RenderOptions*)renderOptions
{
    if(!_renderOptions)
    {
        _renderOptions = [[RenderOptions alloc] init];
    }
    return _renderOptions;
}

- (Metrics*)symbolMetrics
{
    if(!_metrics)
    {
        _metrics = [Metrics metricsZero];
    }
    return _metrics;
}

- (void)setMetrics:(Metrics*)metrics
{
    _metrics = metrics;
}

- (void)setPoint:(VFPoint*)point
{
    self.symbolMetrics.point = point;
}

- (VFPoint*)point
{
    return self.symbolMetrics.point;
}

- (float)width
{
    return self.symbolMetrics.width;
}

- (void)setWidth:(float)width
{
    self.symbolMetrics.width = width;
}

//- (CGContextRef)graphicsContext
//{
//    //    return self.metrics.graphicsContext;
//    return _graphicsContext;
//}

//- (void)setGraphicsContext:(CGContextRef)graphicsContext
//{
//    _graphicsContext = graphicsContext;
//}

- (VFBoundingBox*)getBoundingBox
{
    //    return _metrics.bounds;
    return _boundingBox;
}

- (NSString*)getCode
{
    return self.symbolMetrics.code;
}

- (float)absoluteX;
{
    Metrics* metrics = _metrics;
    return metrics.point.x;
    //    return _boundingBox.xPosition;
}

- (CALayer*)layer
{
    if(!_layer)
    {
        _layer = [CALayer layer];
        _layer.delegate = self;
        [_layer setNeedsDisplay];
    }
    return _layer;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)reset;
{
    _preFormatted = NO;
    _postFormatted = NO;
}

- (BOOL)preFormat;
{
    if(!_preFormatted)
    {
        [self load];
        _preFormatted = YES;
    }
    return YES;
}

- (void)load;
{
    //    if([self.symbolMetrics.code isEqualToString:@""])
    //    {
    //        //        [VFLog LogError:;
    //        //        [VFLog LogVexDump:[NSString stringWithFormat:@"CodeExceptionOnLoading : %@", self.description]];
    //        //        [VFLog LogInfo:[NSString stringWithFormat:@"Attempting to load empty nsstring code: - (void)load
    //        :
    //        //        %@", self.description]];
    //    }

    // self.category = [VFGlyphList nameForCode:self.metrics.code];
    if(self.symbolMetrics.arrayOutline)
    {
        VFLogError(@"SymbolMetricsCodeError, code not set for symbol Metrics object");
        self.symbolMetrics.arrayOutline = [[VFGlyphList sharedInstance] getOutlineForName:self.symbolMetrics.code];
    }
}

- (BOOL)postFormat;
{
    return YES;
}

- (void)draw:(CGContextRef)ctx;
{
    if(!ctx)
    {
        VFLogError(@"NoCanvasContext, Can't draw without a canvas context.");
    }
    //    if (!self.metrics.graphicsContext) {
    //        [VFLog LogError:@"NoCanvasContext: Can't draw without a canvas context."];
    //        return;
    //    }
    //    [self renderWithContext:self.metrics.context];
}

- (void)renderWithContext:(CGContextRef)ctx
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

/** to allow for variable position and scale glyphs
 */
- (void)renderWithContext:(CGContextRef)ctx atPoint:(CGPoint)point withScale:(float)scale forCode:(NSString*)code
{
    //    NSArray *aOutline = [[VFGlyphList availableGlyphsDictionary] objectForKey:code];
}

#pragma mark - CALayer Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name CALayer Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (CGMutablePathRef)pathConvertPoint:(CGPoint)convertPoint
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0 + convertPoint.x, 0 + convertPoint.y);
    return path;
}

- (CGRect)layerFrame
{
    //    return CGRectMake(self.point.x, self.point.y, 0, 0);
    return [[self boundingBox] rect];
}

- (VFShapeLayer*)shapeLayer
{
    VFShapeLayer* ret = [VFShapeLayer layer];

    ret.path = [self pathConvertPoint:self.point.CGPoint];

    return ret;
}

- (void)displayLayer:(CALayer*)layer
{
    layer.frame = self.boundingBox.rect;
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx
{
#if TARGET_OS_IPHONE
    layer.backgroundColor = [[UIColor redColor] CGColor];
#elif TARGET_OS_MAC
    layer.backgroundColor = [[NSColor redColor] CGColor];
#endif
    layer.opacity = 0.5;

    [self draw:ctx];
}

@end
