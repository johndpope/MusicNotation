//
//  VFModifierContext.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

#import "VFModifierContext.h"
#import "VFVex.h"

#import "VFModifier.h"
#import "VFNote.h"
#import "VFDot.h"
#import "VFAccidental.h"
#import "VFStrokes.h"
#import "VFFretHandFinger.h"
#import "VFBend.h"
#import "VFVibrato.h"
#import "VFAnnotation.h"
#import "VFArticulation.h"
#import "VFVex.h"
#import "VFStaffNote.h"
#import "VFGraceNoteGroup.h"
#import "VFStrokes.h"
#import "VFStringNumber.h"
#import "VFArticulation.h"
#import "VFOrnament.h"

#import "VFEnum.h"
#import "VFVex.h"
#import "VFKeyProperty.h"
#import "VFMetrics.h"
#import "VFOptions.h"
#import "VFShiftState.h"
#import "NSString+Ruby.h"
#import "VFMath.h"

#import "OCTotallyLazy.h"

@implementation VFModifierState
- (instancetype)init
{
    self = [super init];
    if (self) {
        _left_shift = 0;
        _right_shift = 0;
        _text_line = 0;
    }
    return self;
}
@end

@interface VFModifierContext ()
{
    BOOL _preFormatted;
    BOOL _postFormatted;
    float _spacing;
    VFModifierState* _state;
}
@property (assign, nonatomic) float width;
@property (assign, nonatomic, readonly, getter=formatted) BOOL formatted;
@property (strong, nonatomic) NSMutableDictionary* modifiersDict;
@property (strong, nonatomic, getter=PREFORMAT) NSArray* PREFORMAT;
@property (strong, nonatomic, getter=POSTFORMAT) NSArray* POSTFORMAT;
@end

@implementation VFModifierContext

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupModifierContext];
    }
    return self;
}

+ (VFModifierContext*)modifierContext;
{
    return [[VFModifierContext alloc] init];
}

- (void)setupModifierContext
{
    // Formatting data.
    _preFormatted = NO;
    _postFormatted = NO;
    _width = 0;
    _spacing = 0;
    _state.left_shift = 0;
    _state.right_shift = 0;
    _state.text_line = 0;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

// Add new modifiers to this array. The ordering is significant -- lower
// modifiers are formatted and rendered before higher ones.
// static NSArray *_PREFORMAT;
- (NSArray*)PREFORMAT
{
    if(!_PREFORMAT)
    {
        _PREFORMAT = @[
            [VFStaffNote class],
            [VFDot class],
            [VFFretHandFinger class],
            [VFAccidental class],
            [VFGraceNoteGroup class],
            [VFStroke class],
            [VFStringNumber class],
            [VFArticulation class],
            [VFOrnament class],
            [VFAnnotation class],
            [VFBend class],
            [VFVibrato class]
        ];
    }
    return _PREFORMAT;
}

// If post-formatting is required for an element, add it to this array.
// static NSArray *_POSTFORMAT;
- (NSArray*)POSTFORMAT
{
    if(!_POSTFORMAT)
    {
        _POSTFORMAT = @[
            [VFStaffNote class],
            //            [VFDot class],
            //            [VFFretHandFinger class],
            //            [VFAccidental class],
            //            [VFGraceNoteGroup class],
            //            [VFStroke class],
            //            [VFStringNumber class],
            //            [VFArticulation class],
            //            [VFOrnament class],
            //            [VFAnnotation class],
            //            [VFBend class],
            //            [VFVibrato class]
        ];
    }
    return _POSTFORMAT;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (NSString*)description
{
    //    //prolog
    //    NSString *ret = [NSString stringWithFormat:@"<%p> : { \n", self];
    //    //guts
    //    //epilog
    //    ret = [ret concat:@"}"];
    //    return [VFLog FormatObject:ret];
    return @"";
}

- (NSMutableDictionary*)modifiersDict
{
    if(!_modifiersDict)
    {
        _modifiersDict = [@
            {
            } mutableCopy];
    }
    return _modifiersDict;
}

- (float)getExtraLeftPx;
{
    return self.state.left_shift;
}

- (float)getExtraRightPx;
{
    return self.state.right_shift;
}

- (float)width
{
    return _width;
}

- (float)extraLeftPx
{
    return self.state.left_shift;
}

- (float)extraRightPx
{
    return self.state.right_shift;
}

- (BOOL)formatted
{
    return self.preFormatted && self.postFormatted;
}

- (Metrics*)metrics
{
    if(!self.formatted)
    {
        VFLogError(@"UnformattedModifier, Unformatted modifier has no metrics.");
    }
    Metrics* ret = [Metrics metricsZero];
    /*
     width: self.state.left_shift + self.state.right_shift + self.spacing,
     spacing: self.spacing,
     extra_left_px: self.state.left_shift,
     extra_right_px: self.state.right_shift
     },*/
    ret.width = self.state.left_shift + self.state.right_shift + self.spacing;
    //    ret.padding.xLeftPadding = self.state.left_shift;
    //    ret.padding.xRightPadding = self.state.right_shift;
    return ret;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)addModifier:(VFModifier*)modifier;
{
    /*
    addModifier: function(modifier) {
        var type = modifier.getCategory();
        if (!self.modifiers[type]) self.modifiers[type] = [];
        self.modifiers[type].push(modifier);
        modifier.setModifierContext(this);
        self.preFormatted = NO;
        return this;
    },
    */
    //    NSString* type = modifier.category;
    NSString* type = [modifier.class CATEGORY];
    if(![self.modifiersDict objectForKey:type])
    {
        [self.modifiersDict setObject:[NSMutableArray array] forKey:type];
    }
    [[self.modifiersDict objectForKey:type] addObject:modifier];
    [modifier setModifierContext:self];
    _preFormatted = NO;
}

- (NSMutableArray*)getModifiersForType:(NSString*)modifierType;
{
    // getModifiers: function(type) { return self.modifiers[type]; },
    return [self.modifiersDict objectForKey:modifierType];
}

- (BOOL)preFormat
{
    /*
    preFormat: function() {
        if (self.preFormatted) return;
        self.PREFORMAT.forEach(function(modifier) {
            L("Preformatting ModifierContext: ", modifier.CATEGORY);
            modifier.format(self.getModifiers(modifier.CATEGORY), self.state, this);
        }, this);

        // Update width of this modifier context
        self.width = self.state.left_shift + self.state.right_shift;
        self.preFormatted = YES;
    },
    */
    if(self.preFormatted)
    {
        return YES;
    }
    __block BOOL success = YES;
    __weak typeof(self) weakSelf = self;
    [self.PREFORMAT foreach:^(Class modifierClass, NSUInteger index, BOOL* stop) {
      NSString* category = [modifierClass CATEGORY];
      // NOTE: uncomment the folloing for more debug info
      //        VFLogDebug(@"%@", [NSString stringWithFormat:@"Preformatting ModifierContext: %@", category]);
      NSMutableArray* modifiers = [self getModifiersForType:category];
      //        [modifierClass performSelector:@selector(format:state:context:) withObject:modifiers
      //        withObject:self.state];

      SEL selector = @selector(format:state:context:);
      NSMethodSignature* signature = [modifierClass methodSignatureForSelector:selector];
      NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
      [invocation setSelector:selector];
      [invocation setTarget:modifierClass];
      [invocation setArgument:&modifiers atIndex:2];
      VFModifierState* state = weakSelf.state;
      [invocation setArgument:&state atIndex:3];
      const __weak VFModifierContext** pointerToMC = &weakSelf;
      [invocation setArgument:pointerToMC atIndex:4];
      [invocation invoke];
      BOOL result;
      [invocation getReturnValue:&result];
      success &= result;
    }];

    // Update width of this modifier context
    self.width = self.state.left_shift + self.state.right_shift;
    _preFormatted = YES;

    return YES;
}

- (BOOL)postFormat
{
    /*
    postFormat: function() {
        if (self.postFormatted) return;
        self.POSTFORMAT.forEach(function(modifier) {
            L("Postformatting ModifierContext: ", modifier.CATEGORY);
            modifier.postFormat(self.getModifiers(modifier.CATEGORY), this);
        }, this);
    }
    */
    if(self.postFormatted)
    {
        return YES;
    }

    [self.POSTFORMAT foreach:^(Class modifierClass, NSUInteger index, BOOL* stop) {
      NSString* category = [modifierClass CATEGORY];
      VFLogDebug(@"%@", [NSString stringWithFormat:@"Postformatting ModifierContext: %@", category]);
      NSArray* modifiers = [self getModifiersForType:category];
      [modifierClass performSelector:@selector(postFormat:) withObject:modifiers];
    }];

    //    _postformatted = YES;
    return YES;
}

@end
