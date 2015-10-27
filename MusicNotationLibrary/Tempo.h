//
//  Tempo.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import "IAModelBase.h"

/** The `Tempo` class wraps tempo data for displaying to the staff

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface Tempo : IAModelBase

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSString* duration;
@property (assign, nonatomic) float dots;
@property (assign, nonatomic) float bpm;

@end
