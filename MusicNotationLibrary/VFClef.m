//
//  VFClef.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFClef.h"
#import <objc/runtime.h>
#import "VFVex.h"
#import "VFTables.h"
#import "VFModifier.h"
#import "VFStaffModifier.h"
#import "VFMetrics.h"
#import "VFBoundingBox.h"
#import "VFPoint.h"
#import "VFStaff.h"
#import "VFMoveableClef.h"
#import "VFTables.h"
#import "VFGlyph.h"
#import "VFPadding.h"

@implementation Annotation

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        //
    }
    return self;
}

+ (Annotation*)annotationWithCode:(NSString*)code point:(float)point line:(float)line xShift:(float)xShift
{
    Annotation* ret = [[Annotation alloc] init];
    ret.code = code;
    ret.point = point;
    ret.line = line;
    ret.xShift = xShift;
    return ret;
}

@end

@implementation VFClef
{
    NSString* _clefName;
}

static float kCLEF_SIZE_DEFAULT = 20;   // 40;
static float kCLEF_SIZE_SMALL = 16;     // 32;

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupClef];
    }
    return self;
}

- (instancetype)initWithType:(VFClefType)clefType
{
    self = [self initWithDictionary:@{ @"type" : @(clefType) }];
    if(self)
    {
        _type = clefType;
        [self setupClef];
        [self setCodeAndName];
    }
    return self;
}

- (instancetype)initWithName:(NSString*)clefName
{
    self = [self initWithDictionary:@{ @"clefName" : clefName }];
    if(self)
    {
        _clefName = clefName;
        _type = [VFClef clefTypeForName:clefName];
        [self setupClef];
        [self setCodeAndName];
    }
    return self;
}

- (instancetype)initWithName:(NSString*)clefName size:(NSString*)size annotationName:(NSString*)annotationName
{
    self = [self initWithDictionary:@{ @"clefName" : clefName }];
    if(self)
    {
        _size = size;
        _type = [VFClef clefTypeForName:clefName];
        _clefName = clefName;
        [self setupClef];
        [self setCodeAndName];
        [self setupWithAnnotationName:annotationName];
    }
    return self;
}

- (instancetype)initWithName:(NSString*)clefName size:(NSString*)size annotation:(Annotation*)annotation
{
    self = [self initWithDictionary:@{ @"clefName" : clefName }];
    if(self)
    {
        _size = size;
        _type = [VFClef clefTypeForName:clefName];
        _clefName = clefName;
        _name = clefName;
        [self setupClef];
        [self setCodeAndName];
        _annotation = annotation;
    }
    return self;
}

+ (VFClef*)trebleClef
{
    return [[VFClef alloc] initWithType:VFClefTreble];
}

+ (VFClef*)clefWithType:(VFClefType)type
{
    if(type == VFClefMovableC)
    {
        return [[VFMovableClef alloc] init];
    }
    else
    {
        return [[VFClef alloc] initWithType:type];
    }
}

+ (VFClef*)clefWithName:(NSString*)clefName;
{
    return [[VFClef alloc] initWithName:clefName size:@"default" annotation:nil];
}

+ (VFClef*)clefWithName:(NSString*)clefName size:(NSString*)size;
{
    return [[VFClef alloc] initWithName:clefName size:size annotation:nil];
}

+ (VFClef*)clefWithName:(NSString*)clefName size:(NSString*)size annotationName:(NSString*)annotationName;
{
    return [[VFClef alloc] initWithName:clefName size:size annotationName:annotationName];
}

+ (VFClef*)clefWithName:(NSString*)clefName size:(NSString*)size annotation:(Annotation*)annotation;
{
    return [[VFClef alloc] initWithName:clefName size:size annotation:annotation];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"clef";
}

#pragma mark - Setup
/**---------------------------------------------------------------------------------------------------------------------
 * @name Setup
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)setupClef
{
    if(!_size)
    {
        self.point.x = kCLEF_SIZE_DEFAULT;
    }
    else
    {
        if([_size isEqualToString:@"default"])
        {
            self.point.x = kCLEF_SIZE_DEFAULT;
        }
        else if([_size isEqualToString:@"small"])
        {
            self.point.x = kCLEF_SIZE_SMALL;
        }
        else
        {
            VFLogError(@"clef size missing error");
        }
    }
    //    self.metrics.padding.xLeftPadding = 55.0;
    //    self.metrics.padding.xRightPadding = 55.0;
    //    [[((Metrics*)self->_metrics)padding] padAllSidesBy:10];
    //    self.metrics.bounds = VFBoundingBox boundingBoxWithRect:<#(CGRect)#>
    //    self.metrics.width
}

- (void)setupWithAnnotationName:(NSString*)name
{
    if(name)
    {
        NSDictionary* anno_dict = VFClef.annotations[name][@"sizes"][self.size];
        NSString* code = VFClef.annotations[name][@"code"];
        float point = [anno_dict[@"point"] floatValue];
        float line = [anno_dict[@"attachments"][self.clefName][@"line"] floatValue];
        float xShift = [anno_dict[@"attachments"][self.clefName][@"x_shift"] floatValue];
        self.annotation = [Annotation annotationWithCode:code point:point line:line xShift:xShift];
    }
}

#pragma mark - Tables
/**---------------------------------------------------------------------------------------------------------------------
 * @name Tables
 * ---------------------------------------------------------------------------------------------------------------------
 */

static NSDictionary* _clefSizes;
// TODO: this might belong in VFTAbles
+ (NSDictionary*)clefSizes
{
    if(!_clefSizes)
    {
        _clefSizes = @{
            @"default" : @(kCLEF_SIZE_DEFAULT),
            @"small" : @(kCLEF_SIZE_SMALL),
        };
    }
    return _clefSizes;
}

static NSDictionary* _annotations;
// TODO: this might belong in VFTAbles
+ (NSDictionary*)annotations
{
    if(!_annotations)
    {
        _annotations = @{
            @"8va" : @{
                @"code" : @"v8",
                @"sizes" : @{
                    @"default" :
                        @{@"point" : @(20), @"attachments" : @{@"treble" : @{@"line" : @(-1.2), @"x_shift" : @(11)}}},
                    @"small" :
                        @{@"point" : @(18), @"attachments" : @{@"treble" : @{@"line" : @(-0.4), @"x_shift" : @(8)}}}
                }
            },
            @"8vb" : @{
                @"code" : @"v8",
                @"sizes" : @{
                    @"default" : @{
                        @"point" : @(20),
                        @"attachments" : @{
                            @"treble" : @{@"line" : @(6.3), @"x_shift" : @(10)},
                            @"bass" : @{@"line" : @(4), @"x_shift" : @(1)}
                        }
                    },
                    @"small" : @{
                        @"point" : @(18),
                        @"attachments" : @{
                            @"treble" : @{@"line" : @(5.8), @"x_shift" : @(6)},
                            @"bass" : @{@"line" : @(3.5), @"x_shift" : @(0.5)}
                        }
                    }
                }
            }
        };
    }
    return _annotations;
}

- (VFClefType)type
{
    if(self.name.length > 0)
    {
        return [[self class] clefTypeForName:self.name];
    }
    else if(_type == VFClefNone)
    {
        return VFClefNone;
    }
    else
    {
        return _type;
    }
}

// TODO: this might belong in VFTAbles or might already be in VFEnem
+ (VFClefType)clefTypeForName:(NSString*)name
{
    NSString* lookup = [name lowercaseString];
    typedef void (^CaseBlock)();
    __block VFClefType ret = 0;
    NSDictionary* d = @{
        @"treble" : ^{
          ret = VFClefTreble;
        },
        @"bass" : ^{
          ret = VFClefBass;
        },
        @"alto" : ^{
          ret = VFClefAlto;
        },
        @"tenor" : ^{
          ret = VFClefTenor;
        },
        @"percussion" : ^{
          ret = VFClefPercussion;
        },
        @"movablec" : ^{
          ret = VFClefMovableC;
        },
        @"soprano" : ^{
          ret = VFClefSoprano;
        },
        @"mezzo-soprano" : ^{
          ret = VFClefMezzoSoprano;
        },
        @"baritone-c" : ^{
          ret = VFClefBaritoneC;
        },
        @"baritone-f" : ^{
          ret = VFClefBaritoneF;
        },
        @"subbass" : ^{
          ret = VFClefSubBass;
        },
        @"french" : ^{
          ret = VFClefFrench;
        },
    };

    ((CaseBlock)d[lookup])();
    if(ret == 0)
    {
        VFLogError(@"BadArgument, unknown name passed as clef type: %@", name);
    }
    return ret;
}

+ (NSString*)clefNameForType:(VFClefType)clefType
{
    switch(clefType)
    {
        case VFClefTreble:
            return @"treble";
            break;
        case VFClefBass:
            return @"bass";
            break;
        case VFClefAlto:
            return @"alto";
            break;
        case VFClefTenor:
            return @"tenor";
            break;
        case VFClefPercussion:
            return @"percussion";
            break;
        case VFClefMovableC:
            return @"movablec";
            break;
        case VFClefMezzoSoprano:
            return @"mezzo-soprano";
            break;
        case VFClefBaritoneC:
            return @"baritone-c";
            break;
        case VFClefBaritoneF:
            return @"baritone-f";
            break;
        case VFClefSubBass:
            return @"subbass";
            break;
        case VFClefFrench:
            return @"french";
            break;
        case VFClefNone:
            return @"clefnone";
            break;
        default:
            VFLogError(@"UnknownClefTypeError");
            return @"";
            break;
    }
}

- (void)setCodeAndName
{
    if(!self->_metrics)
    {
        self->_metrics = [Metrics metricsZero];
    }
    Metrics* metrics = self->_metrics;
    switch(self.type)
    {
        case VFClefTreble:
            //            [metrics setName:@"Treble"];
            self.line = 3;   // [self setLine:2];
            self.code = @"v83";
            self.startingPitch = 46;
            break;
        case VFClefBass:
            //            [metrics setName:@"Bass"];
            self.line = 1;   // [self setLine:4];
            self.code = @"v79";
            self.startingPitch = 32;
            break;
        case VFClefAlto:
            //            [metrics setName:@"Alto"];
            self.line = 2;   // [self setLine:3];
            self.code = @"vad";
            break;
        case VFClefTenor:
            //            [metrics setName:@"Tenor"];
            self.line = 1;   // [self setLine:4];
            self.code = @"vad";
            break;
        case VFClefPercussion:
            //            [metrics setName:@"Percussion"];
            self.line = 2;   // [self setLine:3];
            metrics.code = @"v59";
            break;
        case VFClefMovableC:
            //            [metrics setName:@"MoveableC"];
            self.line = INT32_MAX;   // [self setLine:INT32_MAX];
            self.code = @"v12";
            break;
        case VFClefSoprano:
            //            [metrics setName:@"Soprano"];
            self.line = 4;   // [self setLine:4];
            self.code = @"vad";
            break;
        case VFClefMezzoSoprano:
            //            [metrics setName:@"MezzoSoprano"];
            self.line = 3;   // [self setLine:3];
            self.code = @"vad";
            break;
        case VFClefBaritoneC:
            //            [metrics setName:@"BaritoneC"];
            self.line = 0;   // [self setLine:0];
            self.code = @"vad";
            break;
        case VFClefBaritoneF:
            //            [metrics setName:@"BaritoneF"];
            self.line = 2;   // [self setLine:2];
            self.code = @"v79";
            break;
        case VFClefSubBass:
            //            [metrics setName:@"SubBass"];
            self.line = 0;   // [self setLine:0];
            self.code = @"v79";
            break;
        case VFClefFrench:
            //            [metrics setName:@"French"];
            self.line = 4;   // [self setLine:4];
            self.code = @"v83";
            break;
        default:
            VFLogError(@"bad choice of clef type");
            break;
    }
    metrics.code = self.code;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)setParent:(id)parent
{
    //    [super setParent:parent];
    _parent = parent;
    if([parent isKindOfClass:[VFStaff class]])
    {
        VFStaff* staff = (VFStaff*)parent;
        _staff = staff;
    }
}

- (void)setStaff:(VFStaff*)staff
{
    //    _parent = staff;
    _staff = staff;
}

- (float)line
{
    return _line;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  Add this clef to the start of the given `staff`.
 *  @param staff the staff to add this modifier to
 */
- (void)addModifierToStaff:(VFStaff*)staff;
{
    Metrics* metrics = self->_metrics;
    self.glyph = [VFGlyph glyphWithCode:metrics.code withPointSize:1];
    //    VFLogInfo(@"%@", self.glyph.description);
    [self placeGlyphOnLine:self.glyph forStaff:staff onLine:self.line];
    if(self.annotation)
    {
        VFGlyph* attachment = [[VFGlyph alloc] initWithCode:self.annotation.code withPointSize:self.annotation.point];
        attachment.metrics.xMax = 0;
        attachment.y_shift = 0;
        attachment.x_shift = self.annotation.xShift;
        [self placeGlyphOnLine:attachment forStaff:staff onLine:self.annotation.line];
        [staff addGlyph:attachment];
    }
    [staff addGlyph:self.glyph];
    [staff addGlyph:[staff makeSpacer:self.padding]];
}

/*!
 *  Add this clef to the end of the given `staff`.
 *  @param staff the staff to add this modifier to
 */
- (void)addEndModifierToStaff:(VFStaff*)staff;
{
    Metrics* metrics = self->_metrics;
    self.glyph = [VFGlyph glyphWithCode:metrics.code withPointSize:1];
    [self placeGlyphOnLine:self.glyph forStaff:staff onLine:self.line];
    if(self.annotation)
    {
        VFGlyph* attachment = [[VFGlyph alloc] initWithCode:self.annotation.code withPointSize:self.annotation.point];
        attachment.metrics.xMax = 0;
        attachment.y_shift = 0;
        attachment.x_shift = self.annotation.xShift;
        [self placeGlyphOnLine:attachment forStaff:staff onLine:self.annotation.line];
        [staff addEndGlyph:attachment];
    }
    [staff addEndGlyph:self.glyph];
}

- (BOOL)preFormat
{
    [super preFormat];

    ((Metrics*)self->_metrics).point.x = self.staff.boundingBox.xPosition + ((Metrics*)self->_metrics).point.x;
    //        self.metrics.point.y = [self.staff getYForLine:self.metrics.line];
    return YES;
}

@end
