//
//  VFTablesAccListStruct.h
//  VexFlow
//
//  Created by Scott Riccardelli on 5/22/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"

@interface VFTablesAccListStruct : IAModelBase
@property (strong, nonatomic) NSString* type;
@property (assign, nonatomic) float line;
@end

@interface VFTablesKeySpecStruct : IAModelBase
@property (strong, nonatomic) NSString* acc;
@property (assign, nonatomic) NSUInteger num;
@end