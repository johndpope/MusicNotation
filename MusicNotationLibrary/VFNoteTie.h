//
//  VFNoteTie.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import "IAModelBase.h"

@class VFNote;

//======================================================================================================================
/** The `TieNotes` class  is a struct that has:

 {
 first_note: Note,
 last_note: Note,
 first_indices: [n1, n2, n3],
 last_indices: [n1, n2, n3]
 }

 */
@interface VFNoteTie : IAModelBase
@property (strong, nonatomic) VFNote* first_note;
@property (strong, nonatomic) VFNote* last_note;
@property (strong, nonatomic) NSArray* first_indices;
@property (strong, nonatomic) NSArray* last_indices;

- (instancetype)init;

@end