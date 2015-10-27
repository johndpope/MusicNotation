//
//  VFSize.h
//  VexFlow
//
//  Created by Scott on 3/23/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import "IAModelBase.h"

@interface VFFloatSize : IAModelBase
{
   @private
    float _width;
    float _height;
}
@property (assign, nonatomic) float width;
@property (assign, nonatomic) float height;
+ (VFFloatSize*)sizeWithWidth:(float)width andHeight:(float)height;
@end

@interface VFUIntSize : IAModelBase
{
   @private
    NSUInteger _width;
    NSUInteger _height;
}
@property (assign, nonatomic) NSUInteger width;
@property (assign, nonatomic) NSUInteger height;
+ (VFUIntSize*)sizeWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
@end
