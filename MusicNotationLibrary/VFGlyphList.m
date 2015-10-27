//
//  VFGlyphList.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFGlyphList.h"
#if TARGET_OS_MAC
#import "JSONKit.h"
#endif
#import "VFGlyph.h"
#import "VFVex.h"
#import "VFSize.h"
#import "VFPoint.h"
#import "VFTables.h"

@implementation VFGlyphStruct

- (VFFloatSize *)size
{
    return [[VFGlyphList sharedInstance] sizeForName:self.name];
}

@end

@implementation VFGlyphList
#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (instancetype)sharedInstance;
{
    static VFGlyphList* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedInstance = [[VFGlyphList alloc] init];
      // Do any other initialisation stuff here
    });
    return sharedInstance;
}

#pragma mark - Class methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Class Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

static NSMutableDictionary* _dimensionsDictionary;
static NSMutableDictionary* _anchorPointForGlyphNameDictionary;
- (NSDictionary*)dimensionsDictionary;
{
    if(!_dimensionsDictionary)
    {
        NSUInteger capacity = self.numberOfAvailableGlpyhStucts;
        _dimensionsDictionary = [NSMutableDictionary dictionaryWithCapacity:capacity];
        _anchorPointForGlyphNameDictionary = [NSMutableDictionary dictionaryWithCapacity:capacity];

        for(VFGlyphStruct* glyphStruct in self.availableGlyphStructsArray)
        {
            // record dimensions
            float x = 0, y = 0;
            float left = FLT_MAX, right = FLT_MIN, top = FLT_MAX, bottom = FLT_MIN;
            float scale = kSCALE;

            NSArray* outline = glyphStruct.arrayOutline;

            if(outline.count == 0)
            {
                [VFLog logInfo:@"EmptyOutlineException, outline for self symbol was not initialized."];
                [VFLog logInfo:@"Attempting to look up outline before rendering blockscope proceeds."];
                // attempt to lookup name
                if(glyphStruct.name.length == 0)
                {
                    [VFLog logError:@"SymbolnameEmptyException, name for symbol is empty."];
                }
                glyphStruct.arrayOutline = [self.availableGlyphStructsDictionary objectForKey:glyphStruct.name];
            }

            // TODO: loops twice the number of glyphs, needs fixed
            //            NSLog(glyphStruct.name);

            for(NSUInteger i = 0; i < outline.count;)
            {
                CGPoint pt;
                NSString* action = (NSString*)[outline objectAtIndex:i++];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunsequenced"

                if([action isEqual:@"m"])
                {
                    pt = CGPointMake(x + [(NSNumber*)[outline objectAtIndex:i++] intValue] * scale,
                                     y + [(NSNumber*)[outline objectAtIndex:i++] intValue] * -scale);
                }
                else if([action isEqual:@"l"])
                {
                    pt = CGPointMake(x + [(NSNumber*)[outline objectAtIndex:i++] intValue] * scale,
                                     y + [(NSNumber*)[outline objectAtIndex:i++] intValue] * -scale);
                }
                else if([action isEqual:@"q"])
                {
                    i += 2;
                    pt = CGPointMake(x + [(NSNumber*)[outline objectAtIndex:i++] intValue] * scale,
                                     y + [(NSNumber*)[outline objectAtIndex:i++] intValue] * -scale);
                }
                else if([action isEqual:@"b"])
                {
                    pt = CGPointMake(x + [(NSNumber*)[outline objectAtIndex:i++] intValue] * scale,
                                     y + [(NSNumber*)[outline objectAtIndex:i++] intValue] * -scale);
                    i += 4;
                }
                else
                {
                    //[VFLog LogError:@"draw symbol error."];
                }
                left = pt.x < left ? pt.x : left;
                right = pt.x > right ? pt.x : right;
                top = pt.y < top ? pt.y : top;
                bottom = pt.y > bottom ? pt.y : bottom;

#pragma clang diagnostic pop
            }

            VFFloatSize* size = [[VFFloatSize alloc] init];
            size.width = ABS(left - right);
            size.height = ABS(top - bottom);
            [_dimensionsDictionary setObject:size forKey:glyphStruct.name];

            glyphStruct.anchorPoint = VFPointMake(left, top);
            glyphStruct.size = size;
        }
    }
    return _dimensionsDictionary;
}

- (NSDictionary*)anchorPointForGlyphNameDictionary
{
    if(!_anchorPointForGlyphNameDictionary)
    {
        [self dimensionsDictionary];
    }
    return _anchorPointForGlyphNameDictionary;
}

static NSUInteger _numberOfGlyphStructs = 0;
- (NSUInteger)numberOfAvailableGlpyhStucts;
{
    if(_numberOfGlyphStructs == 0)
    {
        _numberOfGlyphStructs = self.availableGlyphStructsArray.count;
    }
    return _numberOfGlyphStructs;
}

static NSArray* _availableGlyphStructsArray = nil;
- (NSArray*)availableGlyphStructsArray;
{
    if(!_availableGlyphStructsArray)
    {
        NSError* error;
        NSString* path = [[NSBundle mainBundle] pathForResource:@"gonville_all" ofType:@"js"];
        NSData* jsonData =
            [NSData dataWithContentsOfFile:path /*@"gonville_all.js"*/ options:NSDataReadingUncached error:&error];
        if(error)
        {
            VFLogError(@"%@", [error localizedDescription]);
            _availableGlyphStructsArray = nil;
        }
        else
        {
// http://www.14oranges.com/2011/08/how-to-use-jsonkit-for-ios-and-the-rotten-tomatoes-api/
// https://github.com/johnezang/JSONKit

#if TARGET_OS_IPHONE
            NSError* error = [[NSError alloc] init];
            NSDictionary* resultsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
#elif TARGET_OS_MAC
            // TODO: the following line broke in MusicNotationLibrary app
            NSDictionary* resultsDictionary = [jsonData objectFromJSONData];
//            NSError *errorJson=nil;
//            NSDictionary* resultsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions
//            error:&errorJson];

#endif

            NSDictionary* allJSONGlyphs = [[resultsDictionary objectForKey:@"Vex"] objectForKey:@"glyphs"];
            NSMutableArray* tmpArr = [[NSMutableArray alloc] initWithCapacity:allJSONGlyphs.count];
            for(NSString* key in allJSONGlyphs)
            {
                NSString* pathString = [[allJSONGlyphs objectForKey:key] objectForKey:@"o"];
                if(pathString)
                {
                    VFGlyphStruct* glyphStruct = [[VFGlyphStruct alloc] init];
                    glyphStruct.stringOutline = pathString;
                    glyphStruct.arrayOutline =
                        [NSArray arrayWithArray:[glyphStruct.stringOutline componentsSeparatedByString:@" "]];
                    glyphStruct.name = key;
                    [tmpArr addObject:glyphStruct];
                }
            }
            // http://stackoverflow.com/questions/3648411/objective-c-parse-hex-string-to-integer
            NSArray* sortedArray = [tmpArr sortedArrayUsingComparator:^(VFGlyphStruct* a, VFGlyphStruct* b) {
              unsigned int first = 0;
              unsigned int second = 0;

              NSScanner* scanner = [NSScanner scannerWithString:a.name];
              [scanner setScanLocation:1];
              [scanner scanHexInt:&first];

              scanner = [NSScanner scannerWithString:b.name];
              [scanner setScanLocation:1];
              [scanner scanHexInt:&second];

              if(first < second)
              {
                  return (NSComparisonResult)NSOrderedAscending;
              }
              else if(first > second)
              {
                  return (NSComparisonResult)NSOrderedDescending;
              }
              else
              {
                  return (NSComparisonResult)NSOrderedSame;
              }
            }];
            _availableGlyphStructsArray = [NSArray arrayWithArray:sortedArray];
        }
    }
    return _availableGlyphStructsArray;
}

- (VFFloatSize*)sizeForName:(NSString*)name
{
    return self.dimensionsDictionary[name];
}

static NSDictionary* _availableGlyphsDictionary = nil;
- (NSDictionary*)availableGlyphStructsDictionary;
{
    // http://stackoverflow.com/q/3199194/629014
    if(!_availableGlyphsDictionary)
    {
        NSMutableDictionary* tempDict =
            [[NSMutableDictionary alloc] initWithCapacity:self.numberOfAvailableGlpyhStucts];
        for(VFGlyphStruct* glyphStruct in self.availableGlyphStructsArray)
        {
            [tempDict setValue:glyphStruct forKey:glyphStruct.name];
        }
        _availableGlyphsDictionary = [NSDictionary dictionaryWithDictionary:tempDict];
    }
    return _availableGlyphsDictionary;
}

- (NSUInteger)indexForName:(NSString*)name;
{
    unsigned int retIndex = 0;
    NSScanner* scanner = [NSScanner scannerWithString:name];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&retIndex];
    return retIndex;
}

- (NSArray*)getOutlineForName:(NSString*)name;
{
    if(!name || name.length == 0)
    {
        VFLogError(@"EmptyNameForOutlineError");
    }
    return [self.availableGlyphStructsDictionary[name] arrayOutline];
}

@end
