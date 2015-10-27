//
//  CarrierTest.h
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestAction : NSObject

@property (assign, nonatomic) SEL selector;
@property (strong, nonatomic) id target;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) CGRect frame;
@property (strong, nonatomic) NSDictionary* params;
//@property (assign, nonatomic) BOOL cached;

+ (TestAction*)testWithName:(NSString*)name andSelector:(SEL)selector andTarget:(id)target andFrame:(CGRect)frame;

@end
