//
//  VFText.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import "VFPoint.h"
#import "IAModelBase.h"

@class VFFont, VFColor, VFBoundingBox;

/** The `VFText` prints text in a standard format

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFText : IAModelBase

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (strong, nonatomic, readonly) VFFont *font;
@property (strong, nonatomic) VFColor *color;
//@property (strong, nonatomic) NSString *fontName;
//@property (assign, nonatomic) NSUInteger fontSize;
//@property (assign, nonatomic) BOOL fontItalic;
//@property (assign, nonatomic) BOOL fontBold;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
//+ (VFText *)sharedText;

+ (void)setFont:(VFFont *)font;
+ (void)setBold:(BOOL)bold;
+ (void)setItalic:(BOOL)italic;
+ (void)setColor:(VFColor *)color;

//+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(CGPoint)point withHeight:(float)h withText:(NSString *)text;
+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(VFPoint *)point withBounds:(CGRect)bounds withText:(NSString *)text;
+ (void)drawSimpleText:(CGContextRef)ctx withFont:(VFFont *)font atPoint:(VFPoint *)point withText:(NSString *)text;
+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(VFPoint *)point withText:(NSString *)text;
+ (void)drawSimpleText:(CGContextRef)ctx atPoint:(VFPoint *)point withHeight:(float)h withText:(NSString *)text;

+ (void)drawTextWithContext:(CGContextRef)ctx
                    atPoint:(VFPoint *)point
                 withBounds:(VFBoundingBox *)bounds
                   withText:(NSString *)text
               withFontName:(NSString *)fontName
                   fontSize:(NSUInteger)fontSize;

+ (CGSize)measureText:(NSString *)text;
+ (CGSize)measureText:(NSString *)text withFont:(VFFont *)font;

@end

@interface LoremIpsum : NSObject
- (NSString *)words:(NSUInteger)count;
- (NSString *)sentences:(NSUInteger)count;
- (NSString *)randomWord;
@end

@interface NSString (Size)
- (CGSize)attributedSizeWithFont:(VFFont *)font;
- (CGSize)attributedSizeWithFont:(VFFont *)font maxWidth:(CGFloat)width;
@end