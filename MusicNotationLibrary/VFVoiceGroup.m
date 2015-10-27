//
//  VFVoiceGroup.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFVoiceGroup.h"

@interface VFVoiceGroup ()
@property (strong, nonatomic) NSMutableArray* voices;
@property (strong, nonatomic) NSMutableArray* modiferContexts;
@end

@implementation VFVoiceGroup

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupVoiceGroup];
    }
    return self;
}

- (void)setupVoiceGroup
{
    _voices = [[NSMutableArray alloc] init];
    _modiferContexts = [[NSMutableArray alloc] init];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*
Vex.Flow.VoiceGroup.prototype.init = function(time, voiceGroup) {
    self.voices = [];
    self.modifierContexts = [];
}
*/

#pragma mark - Properties

- (NSMutableArray*)voices
{
    if(!_voices)
    {
        _voices = [[NSMutableArray alloc] init];
    }
    return _voices;
}

- (NSMutableArray*)modiferContexts
{
    if(!_modiferContexts)
    {
        _modiferContexts = [[NSMutableArray alloc] init];
    }
    return _modiferContexts;
}

/*
// Every tickable must be associated with a voiceGroup. This allows formatters
// and preformatters to associate them with the right modifierContexts.
Vex.Flow.VoiceGroup.prototype.getVoices = function() {
    return self.voices;
}
 */

#pragma mark - Methods

- (void)addVoices:(NSArray*)objects
{
    [self.voices addObjectsFromArray:objects];
}

- (void)addVoice:(VFVoice*)voice
{
    [self.voices addObject:voice];
}

/*
Vex.Flow.VoiceGroup.prototype.addVoice = function(voice) {
    if (!voice) throw new Vex.RERR("BadArguments", "Voice cannot be null.");
    self.voices.push(voice);
    voice.setVoiceGroup(this);
}
 */

/*
Vex.Flow.VoiceGroup.prototype.getModifierContexts = function() {
    return self.modifierContexts;
}
 */

@end
