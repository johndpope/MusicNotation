//
//  VFTablesGlyphStruct.h
//  VexFlow
//
//  Created by Scott on 3/27/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"
#import "VFMetrics.h"
#import "VFEnum.h"

//@class  Common, Type, GlyphTypeProperties, N, H, M, R, S;

@interface VFTablesGlyphStruct : IAModelBase
//@property (strong, nonatomic) Common *common;
//@property (strong, nonatomic) Type *type;
@property (assign, nonatomic) VFNoteNHMRSType noteNHMRSType;
// following added in addition to tables data
@property (strong, nonatomic) Metrics* metrics;
@property (assign, nonatomic) NSUInteger beamCount;
//@end
//
//
//@interface Common : IAModelBase
@property (assign, nonatomic) float head_width;
@property (assign, nonatomic) BOOL stem;
@property (assign, nonatomic) float stem_offset;
@property (assign, nonatomic) BOOL flag;
@property (assign, nonatomic) NSString* code_flag_upstem;
@property (assign, nonatomic) NSString* code_flag_downstem;
@property (assign, nonatomic) NSInteger stem_up_extension;
@property (assign, nonatomic) NSInteger stem_down_extension;
@property (assign, nonatomic) NSInteger gracenote_stem_up_extension;
@property (assign, nonatomic) NSInteger gracenote_stem_down_extension;
@property (assign, nonatomic) NSInteger tabnote_stem_up_extension;
@property (assign, nonatomic) NSInteger tabnote_stem_down_extension;
@property (assign, nonatomic) NSInteger dot_shiftY;
@property (assign, nonatomic) float line_above;
@property (assign, nonatomic) float line_below;
// following added in addition to tables data
@property (strong, nonatomic) NSString* code_head;
@property (assign, nonatomic) BOOL rest;
@property (strong, nonatomic) NSString* position;

@end
