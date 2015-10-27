//
//  VFMusicDiatonicAccidentals.h
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"

@class IAUnison, IAm2, IAM2, IAm3, IAM3, IAp4, IAdim5, IAp5, IAm6, IAM6, IAb7, IAM7, IAoctave;

@interface VFMusicDiatonicAccidentals : IAModelBase
@property (strong, nonatomic) IAUnison *obj_unison;
@property (strong, nonatomic) IAm2 *obj_m2;
@property (strong, nonatomic) IAM2 *obj_M2;
@property (strong, nonatomic) IAm3 *obj_m3;
@property (strong, nonatomic) IAM3 *obj_M3;
@property (strong, nonatomic) IAp4 *obj_p4;
@property (strong, nonatomic) IAdim5 *obj_dim5;
@property (strong, nonatomic) IAp5 *obj_p5;
@property (strong, nonatomic) IAm6 *obj_m6;
@property (strong, nonatomic) IAM6 *obj_M6;
@property (strong, nonatomic) IAb7 *obj_b7;
@property (strong, nonatomic) IAM7 *obj_M7;
@property (strong, nonatomic) IAoctave *obj_octave;
@end

@interface VFMusicNoteAccidental : IAModelBase
@property (assign, nonatomic) NSUInteger note;
@property (assign, nonatomic) NSUInteger accidental;
@end

@interface IAUnison : VFMusicNoteAccidental
@end
@interface IAm2 : VFMusicNoteAccidental
@end
@interface IAM2 : VFMusicNoteAccidental
@end
@interface IAm3 : VFMusicNoteAccidental
@end
@interface IAp4 : VFMusicNoteAccidental
@end
@interface IAdim5 : VFMusicNoteAccidental
@end
@interface IAp5 : VFMusicNoteAccidental
@end
@interface IAm6 : VFMusicNoteAccidental
@end
@interface IAM6 : VFMusicNoteAccidental
@end
@interface IAb7 : VFMusicNoteAccidental
@end
@interface IAM7 : VFMusicNoteAccidental
@end
@interface IAoctave : VFMusicNoteAccidental
@end


