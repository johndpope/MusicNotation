//
//  VFTextDynamics.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFTextDynamics.h"

@implementation VFTextDynamics
/*
Vex.Flow.TextDynamics = (function(){
    function TextDynamics(text_struct) {
        if (arguments.count > 0) self.init(text_struct);
    }

    // To enable logging for this class. Set `Vex.Flow.TextDynamics.DEBUG` to `YES`.
    function L() { if (TextDynamics.DEBUG) Vex.L("Vex.Flow.TextDynamics", arguments); }

    // The glyph data for each dynamics letter
    TextDynamics.GLYPHS = {
        "f": {
        code: "vba",
        width: 12
        },
        "p": {
        code: "vbf",
        width: 14
        },
        "m": {
        code: "v62",
        width: 17
        },
        "s": {
        code: "v4a",
        width: 10
        },
        "z": {
        code: "v80",
        width: 12
        },
        "r": {
        code: "vb1",
        width: 12
        }
    };
    */

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*
    // ## Prototype Methods
    //
    // A `TextDynamics` object inherits from `Note` so that it can be formatted
    // within a `Voice`.
    Vex.Inherit(TextDynamics, Vex.Flow.Note, {
        // Create the dynamics marking. `text_struct` is an object
        // that contains a `duration` property and a `sequence` of
        // letters that represents the letters to render
    init: function(text_struct) {
        TextDynamics.superclass.init.call(this, text_struct);

        self.sequence = text_struct.text.toLowerCase();
        self.line = text_struct.line || 0;
        self.glyphs = [];

        Vex.Merge(self.render_options, {
        glyph_font_size: 40
        });

        L("New Dynamics Text: ", self.sequence);
    },
 */

/*
        // Set the Stave line on which the note should be placed
    setLine: function(line) { self.line = line;  return this; },
 */

/*
        // Preformat the dynamics text
    preFormat: function() {
        var total_width = 0;
        // Iterate through each letter
        self.sequence.split('').forEach(function(letter) {
            // Get the glyph data for the letter
            var glyph_data = TextDynamics.GLYPHS[letter];
            if (!glyph_data) throw new Vex.RERR("Invalid dynamics character: " + letter);

            var size =  self.render_options.glyph_font_size;
            var glyph = new Vex.Flow.Glyph(glyph_data.code, size);

            // Add the glyph
            self.glyphs.push(glyph);

            total_width += glyph_data.width;
        }, this);

        // Store the width of the text
        self.setWidth(total_width);
        self.preFormatted = YES;
        return this;
    },
 */

/*
        // Draw the dynamics text on the rendering context
    draw: function() {
        var x = self.getAbsoluteX();
        var y = self.stave.getYForLine(self.line + (-3));

        L("Rendering Dynamics: ", self.sequence);

        var letter_x = x;
        self.glyphs.forEach(function(glyph, index) {
            var current_letter = self.sequence[index];
            glyph.render(self.context, letter_x, y);
            letter_x += TextDynamics.GLYPHS[current_letter].width;
        }, this);
    }
    });

    return TextDynamics;
})();
*/
@end
