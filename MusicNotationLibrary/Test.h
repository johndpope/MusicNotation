//
//  Test.h
//  HereWeGoAgain
//
//  Created by Scott Riccardelli on 6/6/15.
//  Copyright (c) 2015 Scott Riccardelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSMutableArray* children;

- (instancetype)initWithName:(NSString*)name;

@end
