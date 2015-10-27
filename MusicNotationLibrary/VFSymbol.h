//
//  VFSymbol.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
@import QuartzCore;
#import "IAModelBase.h"

@class Metrics, Options, VFPoint, VFFloatSize, VFPadding, VFBoundingBox, RenderOptions, VFGlyph, VFColor, VFShapeLayer;

/** The `VFSymbol` class performs ...

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFSymbol : IAModelBase
{
   @public
    id _renderOptions;
    id _metrics;
    BOOL _preFormatted;
    BOOL _postFormatted;
    //    CGContextRef _graphicsContext;

    float _rotationalSkewX, _rotationalSkewY;
    float _scaleX, _scaleY;
    float _vertexZ;
    float _skewX, _skewY;

    VFPoint* _point;
    VFPoint* _anchorPointInPoints;
    VFPoint* _anchorPoint;
    VFFloatSize* _contentSize;
    VFBoundingBox* _boundingBox;
    float _width;
    //    float          _absoluteX;

    CGAffineTransform _transform, _inverse;
    BOOL _isTransformDirty;
    BOOL _isInverseDirty;
    NSInteger _zOrder;

    __weak VFSymbol* _parent;
    NSMutableArray* _children;
    NSString* _name;
    // NSString        *_category;

    id _userObject;
    NSUInteger _orderOfArrival;
    BOOL _visible;
    BOOL _isReorderChildDirty;
    VFColor *_displayColor, *_color;
    BOOL _cascadeColorEnabled, _cascadeOpacityEnabled, _cascadeScaleEnabled;

    CALayer* _layer;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) id metrics;

@property (assign, nonatomic) BOOL preFormatted;
@property (assign, nonatomic) BOOL postFormatted;
//@property (assign, nonatomic) CGContextRef graphicsContext;

@property (assign, nonatomic) float rotationalSkewX;
@property (assign, nonatomic) float rotationalSkewY;
@property (assign, nonatomic) float scaleX;
@property (assign, nonatomic) float scaleY;
@property (assign, nonatomic) float vertexZ;
@property (assign, nonatomic) float skewX;
@property (assign, nonatomic) float skewY;

@property (strong, nonatomic) VFPoint* point;
@property (strong, nonatomic) VFPoint* anchorPointInPoints;
@property (strong, nonatomic) VFPoint* anchorPoint;
@property (strong, nonatomic) VFFloatSize* contentSize;
@property (strong, nonatomic, readonly) VFBoundingBox* boundingBox;
@property (assign, nonatomic) float width;
@property (assign, nonatomic, readonly) float absoluteX;

// staff or note or other parent
@property (weak, nonatomic) VFSymbol* parent;
@property (strong, nonatomic) NSMutableArray* children;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic, readonly) NSString* category;

@property (strong, nonatomic) id userObject;
@property (assign, nonatomic) NSUInteger orderOfArrival;
@property (assign, nonatomic) BOOL visible;
@property (assign, nonatomic) BOOL isReorderChildDirty;
@property (strong, nonatomic) VFColor* displayColor;
@property (strong, nonatomic) VFColor* color;
@property (assign, nonatomic) BOOL cascadeColorEnabled;
@property (assign, nonatomic) BOOL cascadeOpacityEnabled;
@property (assign, nonatomic) BOOL cascadeScaleEnabled;

@property (strong, nonatomic) CALayer* layer;

@property (assign, nonatomic) NSUInteger index;

//- (Metrics *)metrics;
//- (void)setMetrics;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//`````````````````````
// initialize
+ (instancetype)node;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCode:(NSString*)code;
- (instancetype)initWithCode:(NSString*)code withPointSize:(float)pointSize;
//- (instancetype)initWithCode:(NSString *)code
//           atPoint:(VFPoint *)point;
//          withSize:(CGSize)size;

//+ (VFSymbol *)symbol;

//`````````````````````
// description

//- (NSString*)prolog;
//- (NSString*)epilog:(NSString*)desc;

+ (VFSymbol*)symbolWithCode:(NSString*)code withPointSize:(float)pointSize;

- (void)renderWithContext:(CGContextRef)ctx;
//- (void)renderWithCG:(CGContextRef)ctx;
//- (void)renderWithVFKit;

//`````````````````````
// setup

/** loads the glyph outline from the code
 */
- (void)load;
- (void)reset;
- (BOOL)preFormat;
- (BOOL)postFormat;

//`````````````````````
// CALayer Methods

- (CGMutablePathRef)pathConvertPoint:(CGPoint)convertPoint;
- (CGRect)layerFrame;
- (VFShapeLayer*)shapeLayer;

@end
