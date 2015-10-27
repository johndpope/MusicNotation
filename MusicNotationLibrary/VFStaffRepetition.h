//
//  VFStaffRepetition.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"

@class VFStaff;   //, VFFont;

//======================================================================================================================
/** The `VFStaffRepetition` class implements repetitions (Coda, signo, D.C., etc.)

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffRepetition : VFStaffModifier
{
   @private
    float _x;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) VFRepetitionType symbol_type;
//@property (assign, nonatomic) float x;
//@property (assign, nonatomic) NSUInteger y_shift;
//@property (assign, nonatomic) NSUInteger x_shift;

@property (strong, nonatomic) NSString* fontName;
@property (assign, nonatomic) NSUInteger fontSize;
@property (assign, nonatomic) BOOL fontItalic;
@property (assign, nonatomic) BOOL fontBold;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithType:(VFRepetitionType)type x:(float)x y_shift:(float)y_shift;

- (void)draw:(CGContextRef)ctx staff:(VFStaff*)staff x:(float)x;
- (void)drawCodaFixed:(CGContextRef)ctx staff:(VFStaff*)staff x:(float)x;
- (void)drawSignoFixed:(CGContextRef)ctx staff:(VFStaff*)staff x:(float)x;
- (void)drawSymbolText:(CGContextRef)ctx
                 staff:(VFStaff*)staff
                     x:(float)x
              withText:(NSString*)text
                isCoda:(BOOL)drawCoda;

@end
