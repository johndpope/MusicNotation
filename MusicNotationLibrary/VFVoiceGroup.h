//
//  VFVoiceGroup.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "IAModelBase.h"

@class VFVoice;

//======================================================================================================================
/** The `VFVoiceGroup` class performs ...
 
    The following demonstrates some basic usage of this .
 
    ExampleCode
 */
@interface VFVoiceGroup : IAModelBase

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic, readonly) NSMutableArray *voices;
@property (strong, nonatomic, readonly) NSMutableArray *modiferContexts;


#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)addVoices:(NSArray *)objects;
- (void)addVoice:(VFVoice *)voice;

@end
