//
//  VFTablesOrnamentCodes.h
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"

@class OrnamentData;

@interface VFTablesOrnamentCodes : IAModelBase
@property (strong, nonatomic) OrnamentData *mordent;
@property (strong, nonatomic) OrnamentData *mordent_inverted;
@property (strong, nonatomic) OrnamentData *turn;
@property (strong, nonatomic) OrnamentData *turn_inverted;
@property (strong, nonatomic) OrnamentData *tr;
@property (strong, nonatomic) OrnamentData *upprall;
@property (strong, nonatomic) OrnamentData *downprall;
@property (strong, nonatomic) OrnamentData *prallup;
@property (strong, nonatomic) OrnamentData *pralldown;
@property (strong, nonatomic) OrnamentData *upmordent;
@property (strong, nonatomic) OrnamentData *downmordent;
@property (strong, nonatomic) OrnamentData *lineprall;
@property (strong, nonatomic) OrnamentData *prallprall;
@end

@interface OrnamentData : IAModelBase
@property (strong, nonatomic) NSString *code;
@property (assign, nonatomic) NSInteger shift_right;
@property (assign, nonatomic) NSInteger shift_up;
@property (assign, nonatomic) NSInteger shift_down;
@property (assign, nonatomic) NSInteger width;
@property (assign, nonatomic) BOOL between_lines;
@end
