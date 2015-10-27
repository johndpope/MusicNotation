//
//  VFGlyphTabStruct.h
//  VexFlow
//
//  Created by Scott on 6/2/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"

@interface VFGlyphTabStruct : IAModelBase
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* code;
@property (assign, nonatomic) float width;
@property (assign, nonatomic) float shift_y; 
@end
