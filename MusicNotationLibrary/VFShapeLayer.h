//
//  VFShapeLayer.h
//  MusicApp
//
//  Created by Scott on 8/13/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LayerResponder.h"

@class TestViewController;

@interface VFShapeLayer : CAShapeLayer <LayerResponder>

@property (weak, nonatomic) TestViewController* controller;

- (void)animate;

@end



