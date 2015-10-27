//
//  StaffLineRenderOptions.h
//  VexFlow
//
//  Created by Scott on 6/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFRenderOptions.h"
#import "VFEnum.h"
#import "VFColor.h"
//@import AppKit;

//@interface StaffLineRenderOptions : RenderOptions
//
//@end

@interface StaffLineRenderOptions : RenderOptions

@property (strong, nonatomic) NSArray* line_dash;
@property (strong, nonatomic) NSString* color;

@property (assign, nonatomic) BOOL lineDash;
@property (assign, nonatomic) float lineDashPhase;
@property (assign, nonatomic) NSArray* lineDashLengths;
@property (assign, nonatomic) NSUInteger lineDashCount;
@property (assign, nonatomic) float lineWidth;
@property (assign, nonatomic) CGLineCap lineCap;

@property (assign, nonatomic) float padding_left;
@property (assign, nonatomic) float padding_right;

@property (assign, nonatomic) BOOL draw_start_arrow;
@property (assign, nonatomic) BOOL draw_end_arrow;
@property (assign, nonatomic) float arrowhead_length;
@property (assign, nonatomic) float arrowhead_angle;
@property (assign, nonatomic) VFColor* fillColor;
@property (assign, nonatomic) VFColor* strokeColor;

@property (assign, nonatomic) VFStaffLineJustiticationType text_justification;
@property (assign, nonatomic) VFStaffLineVerticalJustifyType text_position_vertical;

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end