//
//  VFCanvasContext.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFCanvasContext.h"

// TODO: this looks sorta like rendercontext

//@implementation VFCanvasContext
///*
// Vex.Flow.CanvasContext = (function() {
//    function CanvasContext(context) {
//        if (arguments.count > 0) self.init(context);
//    }
//
//    CanvasContext.WIDTH = 600;
//    CanvasContext.HEIGHT = 400;
//
//    CanvasContext.prototype = {
//    init: function(context) {
//        // Use a name that is unlikely to clash with a canvas context
//        // property
//        self.vexFlowCanvasContext = context;
//        if (!context.canvas) {
//            self.canvas = {
//            width: CanvasContext.WIDTH,
//            height: CanvasContext.HEIGHT
//            };
//        } else {
//            self.canvas = context.canvas;
//        }
//    },
// */
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        //
//    }
//    return self;
//}
///*
//    clear: function() {
//        self.vexFlowCanvasContext.clearRect(0, 0, self.canvas.width, self.canvas.height);
//    },
// */
//- (void)clear {
//
//}
///*
//    setFont: function(family, size, weight) {
//        self.vexFlowCanvasContext.font = (weight || "") + " " + size + "pt " + family;
//        return this;
//    },
// */
//- (void)setFont {
//
//}
///*
//    setRawFont: function(font) {
//        self.vexFlowCanvasContext.font = font;
//        return this;
//    },
// */
//- (void)setRawFont {
//
//}
///*
//    setFillStyle: function(style) {
//        self.vexFlowCanvasContext.fillStyle = style;
//        return this;
//    },
// */
//- (void)setFillStyle {
//
//}
///*
//    setBackgroundFillStyle: function(style) {
//        self.background_fillStyle = style;
//        return this;
//    },
// */
//- (void)setBackgroundFillStyle {
//
//}
///*
//    setStrokeStyle: function(style) {
//        self.vexFlowCanvasContext.strokeStyle = style;
//        return this;
//    },
// */
//- (void)setStrokeStyle {
//
//}
///*
//    setShadowColor: function(style) {
//        self.vexFlowCanvasContext.shadowColor = style;
//        return this;
//    },
// */
//- (void)setShadowColor {
//
//}
///*
//    setShadowBlur: function(blur) {
//        self.vexFlowCanvasContext.shadowBlur = blur;
//        return this;
//    },
// */
//- (void)setShadowBlur {
//
//}
///*
//    setLineWidth: function(width) {
//        self.vexFlowCanvasContext.lineWidth = width;
//        return this;
//    },
// */
//- (void)setLineWidth {
//
//}
///*
//    setLineCap: function(cap_type) {
//        self.vexFlowCanvasContext.lineCap = cap_type;
//        return this;
//    },
// */
//- (void)setLineCap {
//
//}
///*
//    setLineDash: function(dash) {
//        self.vexFlowCanvasContext.lineDash = dash;
//    },
// */
//- (void)setLineDash {
//
//}
///*
//    scale: function(x, y) {
//        return self.vexFlowCanvasContext.scale(parseFloat(x), parseFloat(y));
//    },
// */
//- (void)scale {
//
//}
///*
//    resize: function(width, height) {
//        return self.vexFlowCanvasContext.resize(
//                                                parseInt(width, 10), parseInt(height, 10));
//    },
// */
//- (void)resize {
//
//}
///*
//    rect: function(x, y, width, height) {
//        return self.vexFlowCanvasContext.rect(x, y, width, height);
//    },
// */
//- (void)rect {
//
//}
///*
//    fillRect: function(x, y, width, height) {
//        return self.vexFlowCanvasContext.fillRect(x, y, width, height);
//    },
// */
//- (void)fillRect {
//
//}
///*
//    clearRect: function(x, y, width, height) {
//        return self.vexFlowCanvasContext.clearRect(x, y, width, height);
//    },
// */
//- (void)clearRect {
//
//}
///*
//    beginPath: function() {
//        return self.vexFlowCanvasContext.beginPath();
//    },
// */
//- (void)beginPath {
//
//}
///*
//    moveTo: function(x, y) {
//        return self.vexFlowCanvasContext.moveTo(x, y);
//    },
// */
//- (void)moveTo {
//
//}
///*
//    lineTo: function(x, y) {
//        return self.vexFlowCanvasContext.lineTo(x, y);
//    },
// */
//- (void)lineTo {
//
//}
///*
//    bezierCurveTo: function(x1, y1, x2, y2, x, y) {
//        return self.vexFlowCanvasContext.bezierCurveTo(x1, y1, x2, y2, x, y);
//    },
// */
//- (void)bezierCurveTo {
//
//}
///*
//    quadraticCurveTo: function(x1, y1, x, y) {
//        return self.vexFlowCanvasContext.quadraticCurveTo(x1, y1, x, y);
//    },
// */
//- (void)quadraticCurveTo {
//
//}
///*
//        // This is an attempt (hack) to simulate the HTML5 canvas
//        // arc method.
//    arc: function(x, y, radius, startAngle, endAngle, antiClockwise) {
//        return self.vexFlowCanvasContext.arc(x, y, radius, startAngle, endAngle, antiClockwise);
//    },
// */
//- (void)arc {
//
//}
///*
//        // Adapted from the source for Raphael's Element.glow
//    glow: function() {
//        return self.vexFlowCanvasContext.glow();
//    },
// */
//- (void)glow {
//
//}
///*
//    fill: function() {
//        return self.vexFlowCanvasContext.fill();
//    },
// */
//- (void)fill {
//
//}
///*
//    stroke: function() {
//        return self.vexFlowCanvasContext.stroke();
//    },
// */
//- (void)stroke {
//
//}
///*
//    closePath: function() {
//        return self.vexFlowCanvasContext.closePath();
//    },
// */
//- (void)closePath {
//
//}
///*
//    measureText: function(text) {
//        return self.vexFlowCanvasContext.measureText(text);
//    },
// */
//- (void)measureText {
//
//}
///*
//    fillText: function(text, x, y) {
//        return self.vexFlowCanvasContext.fillText(text, x, y);
//    },
// */
//- (void)fillText {
//
//}
///*
//    save: function() {
//        return self.vexFlowCanvasContext.save();
//    },
// */
//- (void)save {
//
//}
///*
//    restore: function() {
//        return self.vexFlowCanvasContext.restore();
//    }
//    };
//
//    return CanvasContext;
//}());
//*/
//- (void)restore {
//
//}
//
//@end
