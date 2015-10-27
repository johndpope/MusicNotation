//
//  VFPropertyUtil.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

@import Foundation;

@interface VFPropertyUtil : NSObject

+ (NSDictionary *)classPropsDictForClass:(Class)klass;

+ (NSSet *)classPropNamesSetForClass:(Class)klass;

+ (BOOL)allDictKeys:(NSDictionary *)dict haveClassProperties:(Class)klass;

@end

