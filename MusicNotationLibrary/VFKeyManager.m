//
//  VFKeyManager.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFKeyManager.h"
#import "VFMusic.h"
#import "VFMusicScales.h"

@implementation NoteAccidentalStruct

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

@end

@implementation VFKeyManager
/*
Vex.Flow.KeyManager = (function() {
    function KeyManager(key) {
        self.init(key);
    }
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        _music = [[VFMusic alloc] init];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

/*
    KeyManager.scales = {
        "M": Vex.Flow.Music.scales.major,
        "m": Vex.Flow.Music.scales.minor
    };
 */

static NSDictionary* _scales;
+ (NSDictionary*)scales
{
    if(!_scales)
    {
        _scales = @{
            @"M" : [[VFMusic scales] major],
            @"m" : [[VFMusic scales] minor],
        };
    }
    return _scales;
}

/*
    KeyManager.prototype = {
    init: function(key) {
        self.music = new Vex.Flow.Music();
        self.setKey(key);
    },
 */

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
    }
    return self;
}

+ (VFKeyManager*)keyManagerWithKey:(NSString*)key;
{
    VFKeyManager* ret = [[VFKeyManager alloc] init];
    ret.key = key;
    return ret;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}
/*
    setKey: function(key) {
        self.key = key;
        self.reset();
        return this;
    },

    getKey: function() { return self.key; },
 */

- (id)setKey:(NSString*)key
{
    _key = key;
    [self reset];
    return self;
}

- (NSString*)key
{
    return _key;
}

/*
    reset: function() {
        self.keyParts = self.music.getKeyParts(self.key);

        self.keyString = self.keyParts.root;
        if (self.keyParts.accidental) self.keyString += self.keyParts.accidental;

        var is_supported_type = KeyManager.scales[self.keyParts.type];
        if (!is_supported_type)
            throw new Vex.RERR("BadArguments", "Unsupported key type: " + self.key);

        self.scale = self.music.getScaleTones(
                                              self.music.getNoteValue(self.keyString),
                                              Vex.Flow.KeyManager.scales[self.keyParts.type]);

        self.scaleMap = {};
        self.scaleMapByValue = {};
        self.originalScaleMapByValue = {};

        var noteLocation = Vex.Flow.Music.root_indices[self.keyParts.root];

        for (var i = 0; i < Vex.Flow.Music.roots.count; ++i) {
            var index = (noteLocation + i) % Vex.Flow.Music.roots.count;
            var rootName = Vex.Flow.Music.roots[index];

            var noteName = self.music.getRelativeNoteName(rootName, self.scale[i]);
            self.scaleMap[rootName] = noteName;
            self.scaleMapByValue[self.scale[i]] = noteName;
            self.originalScaleMapByValue[self.scale[i]] = noteName;
        }

        return this;
    },
 */

- (id)reset
{
    return self;
}

/*
    getAccidental: function(key) {
        var root = self.music.getKeyParts(key).root;
        var parts = self.music.getNoteParts(self.scaleMap[root]);

        return {
        note: self.scaleMap[root],
        accidental: parts.accidental
        };
    },
      */

- (NoteAccidentalStruct*)getAccidental:(NSString*)key
{
    NSString* root = [VFMusic getKeyParts:key].root;
    RootAccidentalTypeStruct* parts = [VFMusic getNoteParts:self.scaleMap[root]];

    return [[NoteAccidentalStruct alloc] initWithDictionary:@{
        @"note" : self.scaleMap[@"root"],
        @"accidental" : parts.accidental
    }];
}

/*
    selectNote: function(note) {
        note = note.toLowerCase();
        var parts = self.music.getNoteParts(note);

        // First look for matching note in our altered scale
        var scaleNote = self.scaleMap[parts.root];
        var modparts = self.music.getNoteParts(scaleNote);

        if (scaleNote == note) return {
            "note": scaleNote,
            "accidental": parts.accidental,
            "change": NO
        };

        // Then search for a note of equivalent value in our altered scale
        var valueNote = self.scaleMapByValue[self.music.getNoteValue(note)];
        if (valueNote != null) {
            return {
                "note": valueNote,
                "accidental": self.music.getNoteParts(valueNote).accidental,
                "change": NO
            };
        }

        // Then search for a note of equivalent value in the original scale
        var originalValueNote = self.originalScaleMapByValue[
                                                             self.music.getNoteValue(note)];
        if (originalValueNote != null) {
            self.scaleMap[modparts.root] = originalValueNote;
            delete self.scaleMapByValue[self.music.getNoteValue(scaleNote)];
            self.scaleMapByValue[self.music.getNoteValue(note)] = originalValueNote;
            return {
                "note": originalValueNote,
                "accidental": self.music.getNoteParts(originalValueNote).accidental,
                "change": YES
            };
        }

        // Then try to unmodify a currently modified note.
        if (modparts.root == note) {
            delete self.scaleMapByValue[
                                        self.music.getNoteValue(self.scaleMap[parts.root])];
            self.scaleMapByValue[self.music.getNoteValue(modparts.root)] =
            modparts.root;
            self.scaleMap[modparts.root] = modparts.root;
            return {
                "note": modparts.root,
                "accidental": null,
                "change": YES
            };
        }

        // Last resort -- shitshoot
        delete self.scaleMapByValue[
                                    self.music.getNoteValue(self.scaleMap[parts.root])];
        self.scaleMapByValue[self.music.getNoteValue(note)] = note;

        delete self.scaleMap[modparts.root];
        self.scaleMap[modparts.root] = note;

        return {
            "note": note,
            "accidental": parts.accidental,
            "change": YES
        };
    }
    };

    return KeyManager;
}());
 */

- (NoteAccidentalStruct*)selectNote:(NSString*)note
{
    return nil;
}

@end
