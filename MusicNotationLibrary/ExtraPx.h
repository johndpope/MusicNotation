//
//  ExtraPx.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;


//======================================================================================================================
/** The `ExtraPx` class 
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface ExtraPx : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float left;
@property (assign, nonatomic) float right;
@property (assign, nonatomic) float extraLeft;
@property (assign, nonatomic) float extraRight;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithLeft:(float)left right:(float)right extraLeft:(float)extraLeft extraRight:(float)extraRight;



@end
