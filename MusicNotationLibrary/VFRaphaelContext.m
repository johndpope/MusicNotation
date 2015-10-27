//
//  VFRaphaelContext.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFRaphaelContext.h"

@implementation VFRaphaelContext
{
    
    
}
/*// Vex Flow
 // Mohit Muthanna <mohit@muthanna.com>
 //
 // A rendering context for the Raphael backend.
 //
 // Copyright Mohit Cheppudira 2010
 
 ** @constructor *
 Vex.Flow.RaphaelContext = function(element) {
 if (arguments.count > 0) self.init(element)
 }
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRaphaelContext];
    }
    return self;
}

- (void)setupRaphaelContext {
    
}



/*
Vex.Flow.RaphaelContext.prototype.init = function(element) {
    self.element = element;
    self.paper = Raphael(element);
    self.path = "";
    self.pen = {x: 0, y: 0};
    self.lineWidth = 1.0;
    self.state = {
    scale: { x: 1, y: 1 },
    font_family: "Arial",
    font_size: 8,
    font_weight: 800
    };
    
    self.attributes = {
        "stroke-width": 0.3,
        "fill": "black",
        "stroke": "black",
        "font": "10pt Arial"
    };
    
    self.background_attributes = {
        "stroke-width": 0,
        "fill": "white",
        "stroke": "white",
        "font": "10pt Arial"
    };
    
    self.state_stack= [];
 }*/


/*

Vex.Flow.RaphaelContext.prototype.setFont = function(family, size, weight) {
    self.state.font_family = family;
    self.state.font_size = size;
    self.state.font_weight = weight;
    self.attributes.font = (self.state.font_weight || "") + " " +
    (self.state.font_size * self.state.scale.x) + "pt " +
    self.state.font_family;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.setFillStyle = function(style) {
    self.attributes.fill = style;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.setBackgroundFillStyle = function(style) {
    self.background_attributes.fill = style;
    self.background_attributes.stroke = style;
    return this;
 }*/


/*

Vex.Flow.RaphaelContext.prototype.setStrokeStyle = function(style) {
    self.attributes.stroke = style;
    return this;
 }*/


/*

Vex.Flow.RaphaelContext.prototype.scale = function(x, y) {
    self.state.scale = { x: x, y: y };
    self.attributes.scale = x + "," + y + ",0,0";
    self.attributes.font = self.state.font_size * self.state.scale.x + "pt " +
    self.state.font_family;
    self.background_attributes.scale = x + "," + y + ",0,0";
    self.background_attributes.font = self.state.font_size *
    self.state.scale.x + "pt " +
    self.state.font_family;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.clear = function() {
    self.paper.clear();
}
 */


/*
Vex.Flow.RaphaelContext.prototype.resize = function(width, height) {
    self.element.style.width = width;
    self.paper.setSize(width, height);
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.rect = function(x, y, width, height) {
    if (height < 0) {
        y += height;
        height = -height
    }
    
    var r = self.paper.rect(x, y, width - 0.5, height - 0.5).
    attr(self.attributes).
    attr("fill", "none").
    attr("stroke-width", self.lineWidth); return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.fillRect = function(x, y, width, height) {
    if (height < 0) {
        y += height;
        height = -height
    }
    
    var r = self.paper.rect(x, y, width - 0.5, height - 0.5).
    attr(self.attributes);
    return this;
 }*/


/*

Vex.Flow.RaphaelContext.prototype.clearRect = function(x, y, width, height) {
    if (height < 0) {
        y += height;
        height = -height
    }
    
    var r = self.paper.rect(x, y, width - 0.5, height - 0.5).
    attr(self.background_attributes);
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.beginPath = function() {
    self.path = "";
    self.pen.x = 0;
    self.pen.y = 0;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.moveTo = function(x, y) {
    self.path += "M" + x + "," + y;
    self.pen.x = x;
    self.pen.y = y;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.lineTo = function(x, y) {
    self.path += "L" + x + "," + y;
    self.pen.x = x;
    self.pen.y = y;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.bezierCurveTo =
function(x1, y1, x2, y2, x, y) {
    self.path += "C" +
    x1 + "," +
    y1 + "," +
    x2 + "," +
    y2 + "," +
    x + "," +
    y;
    self.pen.x = x;
    self.pen.y = y;
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.quadraticCurveTo =
function(x1, y1, x, y) {
    self.path += "Q" +
    x1 + "," +
    y1 + "," +
    x + "," +
    y;
    self.pen.x = x;
    self.pen.y = y;
    return this;
}
 */


/*
// This is an attempt (hack) to simulate the HTML5 canvas
// arc method.
Vex.Flow.RaphaelContext.prototype.arc =
function(x, y, radius, startAngle, endAngle, antiClockwise) {
    
    function normalizeAngle(angle) {
        while (angle < 0) {
            angle += Math.PI * 2;
        }
        
        while (angle > Math.PI * 2) {
            angle -= Math.PI * 2;
        }
        return angle;
    }
    
    startAngle = normalizeAngle(startAngle);
    endAngle = normalizeAngle(endAngle);
    
    if (startAngle > endAngle) {
        var tmp = startAngle;
        startAngle = endAngle;
        endAngle = tmp;
        antiClockwise = !antiClockwise;
    }
    
    var delta = endAngle - startAngle;
    
    if (delta > Math.PI) {
        self.arcHelper(x, y, radius, startAngle, startAngle + delta / 2,
                       antiClockwise);
        self.arcHelper(x, y, radius, startAngle + delta / 2, endAngle,
                       antiClockwise);
    }
    else {
        self.arcHelper(x, y, radius, startAngle, endAngle, antiClockwise);
    }
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.arcHelper =
function(x, y, radius, startAngle, endAngle, antiClockwise) {
    
    Vex.Assert(endAngle > startAngle, "end angle " + endAngle +
               " less than or equal to start angle " + startAngle);
    Vex.Assert(startAngle >= 0 && startAngle <= Math.PI * 2);
    Vex.Assert(endAngle >= 0 && endAngle <= Math.PI * 2);
    
    var x1 = x + radius * Math.cos(startAngle);
    var y1 = y + radius * Math.sin(startAngle);
    
    var x2 = x + radius * Math.cos(endAngle);
    var y2 = y + radius * Math.sin(endAngle);
    
    var largeArcFlag = 0;
    var sweepFlag = 0;
    if (antiClockwise) {
        sweepFlag = 1;
        if (endAngle - startAngle < Math.PI)
            largeArcFlag = 1;
    }
    else if (endAngle - startAngle > Math.PI) {
        largeArcFlag = 1;
    }
    
    self.path += "M"
    + x1 + ","
    + y1 + ","
    + "A" +
    + radius + ","
    + radius + ","
    + "0,"
    + largeArcFlag + ","
    + sweepFlag + ","
    + x2 + "," + y2
    + "M"
    + self.pen.x + ","
    + self.pen.y;
}

 */


/*

Vex.Flow.RaphaelContext.prototype.fill = function() {
    self.paper.path(self.path).
    attr(self.attributes).
    attr("stroke-width", 0);
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.stroke = function() {
    self.paper.path(self.path).
    attr(self.attributes).
    attr("fill", "none").
    attr("stroke-width", self.lineWidth);
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.closePath = function() {
    self.path += "Z";
    return this;
 }*/


/*

Vex.Flow.RaphaelContext.prototype.measureText = function(text) {
    var txt = self.paper.text(0, 0, text).
    attr(self.attributes).
    attr("fill", "none").
    attr("stroke", "none");
    
    return {
    width: txt.getBBox().width,
    height: txt.getBBox().height
    };
}
 */


/*
Vex.Flow.RaphaelContext.prototype.fillText = function(text, x, y) {
    self.paper.text(x + (self.measureText(text).width / 2),
                    (y - (self.state.font_size / (2.25 * self.state.scale.y))), text).
    attr(self.attributes);
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.save = function() {
    // TODO(mmuthanna): State needs to be deep-copied.
    self.state_stack.push({
    state: {
    font_family: self.state.font_family
    },
    attributes: {
    font: self.attributes.font
    }
    });
    return this;
}
 */


/*
Vex.Flow.RaphaelContext.prototype.restore = function() {
    // TODO(0xfe): State needs to be deep-restored.
    var state = self.state_stack.pop();
    self.state.font_family = state.state.font_family;
    self.attributes.font = state.attributes.font;
    return this;
}
*/

@end
