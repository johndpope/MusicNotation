//
//  VFGlyph.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFSymbol.h"
#import "VFMetrics.h"

@class VFStaff, VFPoint, CarrierLayer;

@interface GlyphMetrics : Metrics
@property (assign, nonatomic) float x_shift;
@property (assign, nonatomic) float y_shift;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (NSString*)description;
- (NSDictionary*)dictionarySerialization;
@end

typedef void (^DrawCustom)(CGContextRef context, float x, float y);

//======================================================================================================================
/** The `VFGlyph` class is a static glyph renderer.

    The following demonstrates some basic usage of this class.

    ExampleCode
 */
@interface VFGlyph : VFSymbol
{
   @public

   @private
    float _headWidth;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

///**
// */
@property (strong, nonatomic) NSString* position;
//
////@property (strong, nonatomic) VFStaff *Staff;
//@property (strong, nonatomic) NSDictionary *glyphTypes;
//
//

//@property (assign, nonatomic) float dotShiftY;

@property (assign, nonatomic) NSUInteger beamCount;

@property (assign, nonatomic, getter=hasStem) BOOL stem;
@property (assign, nonatomic) BOOL flag;

@property (assign, nonatomic) BOOL rest;

/*!
 *  does not draw anything, only takes up space
 */
@property (assign, nonatomic) BOOL isSpacer;

@property (assign, nonatomic) BOOL cache;
@property (strong, nonatomic) NSString* codeFlagUpstem;
@property (strong, nonatomic) NSArray* aFlagUpstem;
@property (strong, nonatomic) NSString* codeFlagDownstem;
@property (strong, nonatomic) NSArray* aFlagDownstem;

//@property (strong, nonatomic) NSString *category;

//@property (strong, nonatomic) Metrics *metrics;

@property (strong, nonatomic) NSString* code_head;

@property (assign, nonatomic) float x_shift;
@property (assign, nonatomic) float y_shift;

@property (assign, nonatomic) BOOL renderBoundingBox;

@property (strong, nonatomic) DrawCustom drawBlock;

- (NSString*)category;
+ (NSString*)CATEGORY;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCode:(NSString*)code withRect:(CGRect)rect;   // cached:(BOOL)cache andFont:(NSString *)font;

- (instancetype)initWithCode:(NSString*)code withPointSize:(float)point;

- (instancetype)initWithCode:(NSString*)code withScale:(float)scale;

+ (VFGlyph*)glyphWithCode:(NSString*)code withRect:(CGRect)rect;
+ (VFGlyph*)glyphWithCode:(NSString*)code withPointSize:(float)point;

- (void)reset;
- (void)loadMetricsWithFont:(NSString*)font withCode:(NSString*)code andCache:(BOOL)cache;

- (GlyphMetrics*)metrics;

+ (void)setDebugMode:(BOOL)mode;

- (NSDictionary*)dictionarySerialization;

#pragma mark - Render Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Render Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)renderWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff atX:(CGFloat)x;
- (void)renderWithContext:(CGContextRef)ctx atX:(CGFloat)x atY:(CGFloat)y;

- (void)renderWithContext:(CGContextRef)ctx;

+ (void)renderIntoArray:(NSMutableArray*)paths
              transform:(CGAffineTransform*)transform
               withCode:(NSString*)code
              withScale:(float)scale;

+ (CarrierLayer*)createCarrierLayerWithCode:(NSString*)code withScale:(CGFloat)scale hasCross:(BOOL)hasCross;

+ (CGPathRef)createPathwithCode:(NSString*)code withScale:(CGFloat)scale atPoint:(CGPoint)point;

//- (void)renderOutline:(CGContextRef)ctx
//          withOutline:(NSArray*)outline
//             andScale:(CGFloat)scale
//                  atX:(CGFloat)x
//                  atY:(CGFloat)y;

+ (void)renderGlyph:(CGContextRef)ctx withMetrics:(Metrics*)metrics;

+ (void)renderGlyph:(CGContextRef)ctx
                atX:(CGFloat)x
                atY:(CGFloat)y
          withScale:(CGFloat)scale
       forGlyphCode:(NSString*)gCode;

+ (void)renderGlyph:(CGContextRef)ctx
                atX:(CGFloat)x
                atY:(CGFloat)y
          withScale:(CGFloat)scale
       forGlyphCode:(NSString*)gCode
  renderBoundingBox:(BOOL)renderBoundingBox;

@end
