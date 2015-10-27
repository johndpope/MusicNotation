//
//  VFPedalMarking.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Complete

//@import Foundation;
#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import UIKit;
#elif TARGET_OS_MAC
@import AppKit;
#endif

@class VFColor;

typedef NS_ENUM(NSInteger, VFPedalMarkingType) {
    VFPedalMarkingText = 1,
    VFPedalMarkingBracket = 2,
    VFPedalMarkingMixed = 3
};

/** The `VFPedalMarking` class performs implements different types of pedal markings. These notation
      elements indicate to the performer when to depress and release the a pedal.
     
      In order to create "Sostenuto", and "una corda" markings, you must set
      custom text for the release/depress pedal markings.
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFPedalMarking : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSArray *notes;
@property (assign, nonatomic) VFPedalMarkingType style;
@property (assign, nonatomic) float line;
@property (strong, nonatomic) NSString *custom_depress_text;
@property (strong, nonatomic) NSString *custom_release_text;

@property (strong, nonatomic) NSString *fontFamily;
@property (assign, nonatomic) float fontSize;
@property (assign, nonatomic) BOOL fontBold;
@property (assign, nonatomic) BOOL fontItalic;

@property (assign, nonatomic) float bracket_height;
@property (assign, nonatomic) float text_margin_right;
@property (assign, nonatomic) float bracket_line_width;
@property (assign, nonatomic) float glyph_point_size;
@property (strong, nonatomic) VFColor *color;

@property (assign, nonatomic) CGContextRef graphicsContext;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithNotes:(NSArray *)notes;
+ (VFPedalMarking *)pedalMarkingWithNotes:(NSArray *)notes;

+ (VFPedalMarking *)createUnaCorda:(NSArray *)notes;
+ (VFPedalMarking *)createSustain:(NSArray *)notes;
+ (VFPedalMarking *)createSostenuto:(NSArray *)notes;


- (void)setCustomText:(NSString*)text;
- (void)setCustomTextDepress:(NSString *)depressText release:(NSString *)releaseText;
- (void)setStyle:(VFPedalMarkingType)style;
- (void)setLine:(float)line;

- (void)drawBracketed:(CGContextRef)ctx;
- (void)drawText:(CGContextRef)ctx;

- (void)draw:(CGContextRef)ctx;

@end
