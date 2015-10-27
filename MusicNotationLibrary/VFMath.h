//
//  VFMath.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;

float vfmax(float a, float b);
float vfmin(float a, float b);
float vfroundN(NSInteger x, NSInteger n);
NSUInteger vfmidline(NSUInteger a, NSUInteger b);

@interface VFMath : NSObject
+ (float)Max:(float)a :(float)b;
+ (float)roundN:(NSInteger)n withX:(NSInteger)x;
+ (float)midLineOf:(float)a and:(float)b;
@end
