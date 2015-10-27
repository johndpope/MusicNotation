//
//  VFStaffTie.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

@import Foundation;

#import "VFStaffModifier.h"

@class VFStaffNote, VFNoteTie;

//======================================================================================================================
/** The `VFStaffTie` class implements various types of ties between contiguous notes.
    Ties include reuglar ties, hammer ons, pull offs, and slides.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffTie : VFStaffModifier

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic, readonly) BOOL isPartial;
@property (strong, nonatomic) VFNoteTie* notes;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) VFStaffNote* firstNote;
@property (strong, nonatomic) NSArray* firstIndices;
@property (strong, nonatomic) NSArray* lastIndices;
@property (assign, nonatomic) NSUInteger firstIndex;
@property (strong, nonatomic) VFStaffNote* lastNote;
@property (assign, nonatomic) NSUInteger lastIndex;
@property (assign, nonatomic) float cp1;
@property (assign, nonatomic) float cp2;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary andText:(NSString*)text;
- (instancetype)initWithLastNote:(VFNote*)last_note
                       firstNote:(VFNote*)first_note
                    firstIndices:(NSArray*)first_indices
                     lastIndices:(NSArray*)last_indices;

@end
