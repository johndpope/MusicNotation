//
//  Term.h
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreParse/CPParser.h>

@interface Term : NSObject <CPParseResult>

@property (readwrite, assign) float value;

@end
