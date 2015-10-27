//
//  VFStaffLine.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFModifier.h"
#import "VFRenderOptions.h"
#import "StaffLineRenderOptions.h"

// Text Positioning
/*
StaveLine.TextVerticalPosition = {
TOP: 1,
BOTTOM: 2
};

StaveLine.TextJustification = {
LEFT: 1,
CENTER: 2,
RIGHT: 3
};
 */

@class StaffLineRenderOptions;

@interface StaffLineNotesStruct : IAModelBase
@property (strong, nonatomic) VFStaffNote* first_note;   //    first_note: Note,
@property (strong, nonatomic) VFStaffNote* last_note;    //    last_note: Note,
@property (strong, nonatomic) NSArray* first_indices;    //    first_indices: [n1, n2, n3],
@property (strong, nonatomic) NSArray* last_indices;     //    last_indices: [n1, n2, n3]
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

//======================================================================================================================
/** The `VFStaffLine` class implements `StaveLine` which are simply lines that connect
      two notes. This object is highly configurable, see the `render_options`.
      A simple line is often used for notating glissando articulations, but you
      can format a `StaveLine` with arrows or colors for more pedagogical
      purposes, such as diagrams.

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFStaffLine : VFModifier
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (strong, nonatomic) VFFont* font;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) StaffLineNotesStruct* staff_line_notes;
- (id)setNotes:(StaffLineNotesStruct*)notes;
- (StaffLineRenderOptions*)renderOptions;
- (id)setRenderOptions:(StaffLineRenderOptions*)renderOptions;
@property (strong, nonatomic) VFStaffNote* first_note;
@property (strong, nonatomic) NSArray* first_indices;
@property (strong, nonatomic) VFStaffNote* last_note;
@property (strong, nonatomic) NSArray* last_indices;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNotes:(StaffLineNotesStruct*)notes;

@end
