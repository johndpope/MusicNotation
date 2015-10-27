//
//  Header.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

#ifndef VFVexCore_Header_h
#define VFVexCore_Header_h

// TODO: add in additional headers

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import UIKit;
//#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
@import AppKit;
#import <Cocoa/Cocoa.h>
#endif

#import "vfMacros.h"

#import "VFAccidental.h"
#import "VFAnnotation.h"
#import "VFArticulation.h"
#import "VFBarNote.h"
#import "VFBeam.h"
#import "VFBend.h"
#import "VFBezierPath.h"
#import "VFBoundingBox.h"
#import "VFChart.h"
#import "VFChord.h"
#import "VFClef.h"
#import "VFClefNote.h"
#import "VFCurve.h"
#import "VFMoveableClef.h"
#import "VFDot.h"
#import "VFEnum.h"
#import "VFFont.h"
#import "VFFormatter.h"
#import "Rational.h"
#import "VFFretHandFinger.h"
#import "VFGhostNote.h"
#import "VFGlyph.h"
#import "VFGlyphList.h"
#import "VFGraceNote.h"
#import "VFGraceNoteGroup.h"
#import "VFKeyManager.h"
#import "VFKeyManager.h"
#import "VFKeySignature.h"
#import "VFKeyProperty.h"
#import "VFMetrics.h"
#import "VFModifier.h"
#import "VFModifierContext.h"
#import "VFMusic.h"
#import "VFNote.h"
#import "VFOrnament.h"
#import "VFPedalMarking.h"
#import "VFRenderer.h"
#import "VFShapeLayer.h"
#import "VFSize.h"
#import "VFStaff.h"
#import "StaffLineRenderOptions.h"
#import "VFStaffBarLine.h"
#import "VFStaffConnector.h"
#import "VFStaffHairpin.h"
#import "VFStaffLine.h"
#import "VFStaffModifier.h"
#import "VFStaffNote.h"
#import "VFStaffRepetition.h"
#import "VFStaffSection.h"
#import "VFStaffTempo.h"
#import "VFStaffTie.h"
#import "VFStaffVolta.h"
#import "VFStringNumber.h"
#import "VFStrokes.h"
#import "VFTables.h"
#import "VFTableTypes.h"
#import "VFTabNote.h"
#import "VFTabStaff.h"
#import "VFTabTie.h"
#import "VFTextNote.h"
#import "VFText.h"
#import "VFTickable.h"
#import "VFTickContext.h"
#import "VFTimeSignature.h"
#import "VFTimeSigNote.h"
#import "VFTremulo.h"
#import "VFTuning.h"
#import "VFTuplet.h"
#import "VFTypes.h"
#import "VFUtils.h"
#import "VFVibrato.h"
#import "VFVoice.h"
#import "VFVoiceGroup.h"
#import "VFShift.h"
#endif
