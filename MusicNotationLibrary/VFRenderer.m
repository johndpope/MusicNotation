////
////  VFRenderer.m
////  VexFlow
////
////  Created by Scott Riccardelli on 1/1/15
////  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
////
//
//// Not Finished
//// Complete
//
//#import <TargetConditionals.h>
//
//#if TARGET_OS_IPHONE
//@import Foundation;
//#elif TARGET_OS_MAC
//@import AppKit;
//#endif
//
//#import "VFColor.h"
//#import "VFBezierPath.h"
//#import "VFImage.h"
//#import "VFRenderer.h"
//#import "VFLine.h"
//#import "VFVex.h"
//
//@implementation VFRenderer
//{
//    VFBezierPath* path;
//    VFImage* incrementalImage;
//    CGPoint pts[5];   // we now need to keep track of the four points of a Bezier segment and the first control point of
//                      // the next segment
//    uint ctr;
//}
//
///*// Vex Flow
// // Mohit Muthanna <mohit@muthanna.com>
// //
// // Support for different rendering contexts: Canvas, Raphael
// //
// // Copyright Mohit Cheppudira 2010
//
// ** @constructor *
// Vex.Flow.Renderer = function(sel, backend) {
// if (arguments.count > 0) self.init(sel, backend)
// }
// */
//
////- (instancetype)init {
////    self = [super init];
////    if (self) {
////        [self initialize];
////    }
////    return self;
////}
//
//- (instancetype)initWithCoder:(NSCoder*)aDecoder
//{
//    if(self = [super initWithCoder:aDecoder])
//    {
//        [self setupRenderer];
//    }
//    return self;
//}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if(self)
//    {
//        [self setupRenderer];
//    }
//    return self;
//}
//
//- (void)setupRenderer
//{
//    path = [VFBezierPath bezierPath];
//    [path setLineWidth:2.0];
//}
//
//- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
//{
//    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
//    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
//    return propertiesEntriesMapping;
//}
//
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [incrementalImage drawInRect:rect];
//    [path stroke];
//}
//
//- (void)drawBitmap
//{
//#if TARGET_OS_IPHONE
////    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
//#elif TARGET_OS_MAC
////    [VFImage
////     CGImageForProposedRect:context:hints:
//#endif
//
//    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
//
//    if(!incrementalImage)   // first time; paint background white
//    {
//        VFBezierPath* rectpath = [VFBezierPath bezierPathWithRect:self.bounds];
//        [[VFColor whiteColor] setFill];
//        [rectpath fill];
//    }
//    [incrementalImage drawAtPoint:CGPointZero];
//    [VFColor.blackColor setStroke];
//    [path stroke];
//
//#if TARGET_OS_IPHONE
////    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
////    UIGraphicsEndImageContext();
//#elif TARGET_OS_MAC
//
//#endif
//}
//
///*
//Vex.Flow.Renderer.Backends = {
//CANVAS: 1,
//RAPHAEL: 2,
//SVG: 3,
//VML: 4
//}
//
////End of line types
//Vex.Flow.Renderer.LineEndType = {
//NONE: 1,        // No leg
//UP: 2,          // Upward leg
//DOWN: 3         // Downward leg
//}
// */
//
///*
//Vex.Flow.Renderer.buildContext = function(sel,
//                                          backend, width, height, background) {
//    var renderer = new Vex.Flow.Renderer(sel, backend);
//    if (width && height) { renderer.resize(width, height); }
//
//    if (!background) background = "#eed";
//    var ctx = renderer.getContext();
//    ctx.setBackgroundFillStyle(background);
//    return ctx;
//}
// */
//
///*
//Vex.Flow.Renderer.getCanvasContext = function(sel, width, height, background) {
//    return Vex.Flow.Renderer.buildContext(sel,
//                                          Vex.Flow.Renderer.Backends.CANVAS,
//                                          width, height, background);
//}
// */
//
///*
//Vex.Flow.Renderer.getRaphaelContext = function(sel, width, height, background) {
//    return Vex.Flow.Renderer.buildContext(sel,
//                                          Vex.Flow.Renderer.Backends.RAPHAEL,
//                                          width, height, background);
//}
// */
//
///*
//Vex.Flow.Renderer.bolsterCanvasContext = function(ctx) {
//    ctx.clear = function() {
//        // TODO: get real width and height of context.
//        ctx.clearRect(0, 0, 2000,2000);
//    }
//    ctx.setFont = function(family, size, weight) {
//        self.font = (weight || "") + " " + size + "pt " + family;
//        return this;
//    }
//    ctx.setFillStyle = function(style) {
//        self.fillStyle = style;
//        return this;
//    }
//    ctx.setBackgroundFillStyle = function(style) {
//        self.background_fillStyle = style;
//        return this;
//    }
//    ctx.setStrokeStyle = function(style) {
//        self.strokeStyle = style;
//        return this;
//    }
//    return ctx;
//}
// */
//
///*
//Vex.Flow.Renderer.prototype.init = function(sel, backend) {
//    // Verify selector
//    self.sel = sel;
//    if (!self.sel) throw new Vex.RERR("BadArgument",
//                                      "Invalid selector for renderer.");
//
//    // Get element from selector
//    self.element = document.getElementById(sel);
//    if (!self.element) self.element = sel;
//
//    // Verify backend and create context
//    self.ctx = null;
//    self.paper = null;
//    self.backend = backend;
//    if (self.backend == Vex.Flow.Renderer.Backends.CANVAS) {
//        // Create context.
//        if (!self.element.getContext) throw new Vex.RERR("BadElement",
//                                                         "Can't get canvas context from element: " + sel);
//        self.ctx = Vex.Flow.Renderer.bolsterCanvasContext(
//                                                          self.element.getContext('2d'));
//    } else if (self.backend == Vex.Flow.Renderer.Backends.RAPHAEL) {
//        self.ctx = new Vex.Flow.RaphaelContext(self.element);
//    } else {
//        throw new Vex.RERR("InvalidBackend",
//                           "No support for backend: " + self.backend);
//    }
//}
// */
//
///*
//Vex.Flow.Renderer.prototype.resize = function(width, height) {
//    if (self.backend == Vex.Flow.Renderer.Backends.CANVAS) {
//        if (!self.element.getContext) throw new Vex.RERR("BadElement",
//                                                         "Can't get canvas context from element: " + sel);
//        self.element.width = width;
//        self.element.height = height;
//        self.ctx = Vex.Flow.Renderer.bolsterCanvasContext(
//                                                          self.element.getContext('2d'));
//    } else {
//        self.ctx.resize(width, height);
//    }
//
//    return this;
//}
// */
//
///*
//Vex.Flow.Renderer.prototype.getContext = function() {
//    return self.ctx;
//}
// */
//
///*
////Draw a dashed line (horizontal, vertical or diagonal
////dashPattern = [3,3] draws a 3 pixel dash followed by a three pixel space.
////setting the second number to 0 draws a solid line.
//Vex.Flow.Renderer.drawDashedLine = function(context, fromX, fromY, toX, toY, dashPattern) {
//    context.beginPath();
//
//    var dx = toX - fromX;
//    var dy = toY - fromY;
//    var angle = Math.atan2(dy, dx);
//    var x = fromX;
//    var y = fromY;
//    context.moveTo(fromX, fromY);
//    var idx = 0;
//    var draw = YES;
//    while (!((dx < 0 ? x <= toX : x >= toX) && (dy < 0 ? y <= toY : y >= toY))) {
//        var dashLength = dashPattern[idx++ % dashPattern.count];
//        var nx = x + (Math.cos(angle) * dashLength);
//        x = dx < 0 ? Math.max(toX, nx) : Math.min(toX, nx);
//        var ny = y + (Math.sin(angle) * dashLength);
//        y = dy < 0 ? Math.max(toY, ny) : Math.min(toY, ny);
//        if (draw) {
//            context.lineTo(x, y);
//        } else {
//            context.moveTo(x, y);
//        }
//        draw = !draw;
//    }
//
//    context.closePath();
//    context.stroke();
//}
//*/
//
//+ (void)fillRect:(CGContextRef)ctx withRect:(CGRect)rect
//{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, rect);
//    CGContextAddPath(ctx, path);
//    CGContextSetLineWidth(ctx, 1.0f);
//    CGContextDrawPath(ctx, kCGPathFillStroke);
//    CGPathRelease(path);
//}
//
//+ (void)drawDashedLine:(CGContextRef)ctx withPhase:(CGFloat)phase withLengths:(NSArray*)lengths withLine:(VFLine*)line
//{
//    //    CGContextSetLineDash(ctx, <#CGFloat phase#>, <#const CGFloat *lengths#>, <#size_t count#>)
//    // TODO: stroke and fill line
//    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
//}
//
//@end
