//
//  VFTablesNoteData.h
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"
#import "JSONSerialization.h"
#import "VFEnum.h"

@class Rational;   //, VFTablesNoteStringData;

//@interface VFTablesNoteData : IAModelBase
//{
//    VFTablesNoteStringData* _durationStringData;
//    Rational* _ticks;
//}
//@property (strong, nonatomic) VFTablesNoteStringData* durationStringData;
//
//@end

@interface VFTablesNoteInputData : IAModelBase
{
    NSString* _durationString;
    VFNoteDurationType _noteDurationType;
    NSString* _noteNHMRSString;
    VFNoteNHMRSType _noteNHMRSType;
    NSUInteger _dots;
}
@property (strong, nonatomic) NSString* durationString;
@property (assign, nonatomic) VFNoteDurationType noteDurationType;
@property (strong, nonatomic) NSString* noteNHMRSString;
@property (assign, nonatomic) VFNoteNHMRSType noteNHMRSType;
@property (assign, nonatomic) NSUInteger dots;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@interface VFTablesNoteStringData : IAModelBase
{
    NSString* _durationString;
    VFNoteDurationType _noteDurationType;
    NSString* _noteNHMRSString;
    VFNoteNHMRSType _noteNHMRSType;
    NSUInteger _dots;
    Rational* _ticks;
}
@property (strong, nonatomic) NSString* durationString;
@property (assign, nonatomic) VFNoteDurationType noteDurationType;
@property (strong, nonatomic) NSString* noteNHMRSString;
@property (assign, nonatomic) VFNoteNHMRSType noteNHMRSType;
@property (assign, nonatomic) NSUInteger dots;
@property (strong, nonatomic) Rational* ticks;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end
