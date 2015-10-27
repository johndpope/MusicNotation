//
//  TestTuple.h
//  MusicApp
//
//  Created by Scott on 8/7/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DrawTest)(CGRect dirtyRect, CGRect bounds, CGContextRef ctx);

@class VFFormatter, VFVoice, VFStaff;

@interface TestTuple : NSObject

@property (strong, nonatomic) NSMutableArray* formatters;
@property (strong, nonatomic) NSMutableArray* voices;
@property (strong, nonatomic) NSMutableArray* staves;
@property (strong, nonatomic) NSMutableArray* beams;

@property (strong, nonatomic) DrawTest drawBlock;

+ (TestTuple*)testTuple;

// test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {

@end