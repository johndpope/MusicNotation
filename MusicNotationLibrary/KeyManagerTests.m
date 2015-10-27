//
//  KeyManagerTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "KeyManagerTests.h"
#import "VexFlowTestHelpers.h"

@implementation KeyManagerTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Valid Notes"  func:@selector(works)];
    [self runTest:@"Select Notes"  func:@selector(selectNotes)];
}




- (void)works
{
    expect(@"1");

    VFKeyManager* manager = [VFKeyManager keyManagerWithKey:@"g"];
    assertThatBool([((NSString*)[manager getAccidental:@"f"].accidental)isEqualToString:@"#"], isTrue());

    [manager setKey:@"a"];
    assertThatBool([((NSString*)[manager getAccidental:@"c"].accidental)isEqualToString:@"#"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"a"].accidental)isEqualToString:@""], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"f"].accidental)isEqualToString:@"#"], isTrue());

    [manager setKey:@"A"];
    assertThatBool([((NSString*)[manager getAccidental:@"c"].accidental)isEqualToString:@"#"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"a"].accidental)isEqualToString:@""], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"f"].accidental)isEqualToString:@"#"], isTrue());
}

- (void)selectNotes
{
    VFKeyManager* manager = [VFKeyManager keyManagerWithKey:@"f"];
    assertThatBool([((NSString*)[manager getAccidental:@"bb"].note)isEqualToString:@"bb"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"bb"].accidental)isEqualToString:@"b"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].note)isEqualToString:@"g"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].accidental)isEqualToString:@""], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].note)isEqualToString:@"b"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].accidental)isEqualToString:@""], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"a#"].note)isEqualToString:@"bb"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g#"].note)isEqualToString:@"g#"], isTrue());

    // Changes have no effect?
    assertThatBool([((NSString*)[manager getAccidental:@"g#"].note)isEqualToString:@"g#"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"bb"].note)isEqualToString:@"bb"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"bb"].accidental)isEqualToString:@"b"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].note)isEqualToString:@"g"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].accidental)isEqualToString:@""], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].note)isEqualToString:@"b"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g"].accidental)isEqualToString:@""], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"a#"].note)isEqualToString:@"bb"], isTrue());
    assertThatBool([((NSString*)[manager getAccidental:@"g#"].note)isEqualToString:@"g#"], isTrue());

    // Changes should propagate
    [manager reset];
    assertThatBool([manager selectNote:@"g#"].change, isTrue());
    assertThatBool([manager selectNote:@"g#"].change, isFalse());
    assertThatBool([manager selectNote:@"g"].change, isTrue());
    assertThatBool([manager selectNote:@"g"].change, isFalse());
    assertThatBool([manager selectNote:@"g#"].change, isTrue());

    [manager reset];
    NoteAccidentalStruct* note;

    note = [manager selectNote:@"bb"];
    assertThatBool(note.change, isFalse());
    assertThatBool([note.accidental isEqualToString:@"b"], isTrue());

    note = [manager selectNote:@"g"];
    assertThatBool(note.change, isFalse());
    assertThatBool([note.accidental isEqualToString:@""], isTrue());

    note = [manager selectNote:@"g#"];
    assertThatBool(note.change, isTrue());
    assertThatBool([note.accidental isEqualToString:@"#"], isTrue());

    note = [manager selectNote:@"g"];
    assertThatBool(note.change, isTrue());
    assertThatBool([note.accidental isEqualToString:@""], isTrue());

    note = [manager selectNote:@"g"];
    assertThatBool(note.change, isFalse());
    assertThatBool([note.accidental isEqualToString:@""], isTrue());

    note = [manager selectNote:@"g#"];
    assertThatBool(note.change, isFalse());
    assertThatBool([note.accidental isEqualToString:@"#"], isTrue());
}

@end
