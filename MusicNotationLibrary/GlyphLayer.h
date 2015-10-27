//
//  GlyphLayer.h
//  MusicApp
//
//  Created by Scott on 8/11/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LayerResponder.h"

// TODO: rename this file to GlyphShapeLayer

@interface GlyphShapeLayer : CAShapeLayer <LayerResponder>

- (void)animate;

@end



