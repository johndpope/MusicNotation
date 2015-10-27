//
//  Animation.h
//  VexFlow
//
//  Created by Scott on 6/7/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@protocol Animation <NSObject>
@required
- (void)animationTick:(CFTimeInterval)dt finished:(BOOL*)finished;

@end
