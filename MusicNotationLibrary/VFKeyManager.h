//
//  VFKeyManager.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "IAModelBase.h"

@class VFMusic, NoteAccidentalStruct;

//======================================================================================================================
/** The `VFKeyManager` class performs ...

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFKeyManager : IAModelBase
{
    NSString* _key;
    VFMusic* _music;
    NSMutableDictionary* _scaleMap;
    NSMutableDictionary* _scaleMapByValue;
    NSMutableDictionary* _originalScaleMapByValue;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (strong, nonatomic) NSString* key;
@property (strong, nonatomic) NSMutableDictionary* scaleMap;
@property (strong, nonatomic) NSMutableDictionary* scaleMapByValue;
@property (strong, nonatomic) NSMutableDictionary* originalScaleMapByValue;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

+ (NSDictionary*)scales;

+ (VFKeyManager*)keyManagerWithKey:(NSString*)key;

- (id)setKey:(NSString*)key;
- (NSString*)key;
- (id)reset;
- (NoteAccidentalStruct*)getAccidental:(NSString*)key;
- (NoteAccidentalStruct*)selectNote:(NSString*)note;

@end

//@class VFNote, VFAccidental;

@interface NoteAccidentalStruct : IAModelBase
@property (strong, nonatomic) NSString* note;
@property (strong, nonatomic) NSString* accidental;
@property (assign, nonatomic) BOOL change;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end