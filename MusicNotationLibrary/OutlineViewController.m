//
//  OutlineViewController.m
//  HereWeGoAgain
//
//  Created by Scott Riccardelli on 6/6/15.
//  Copyright (c) 2015 Scott Riccardelli. All rights reserved.
//

#import "OutlineViewController.h"
#import "Test.h"
#import "TestType.h"
#import "OCTotallyLazy.h"
#import "NSString+Additions.h"

@interface OutlineViewController ()

@property (weak) IBOutlet NSOutlineView* outlineView;

@end

@implementation OutlineViewController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self load];
    }
    return self;
}

- (void)load
{
    _tests = [NSMutableArray array];

    //    Test* test1 = [[Test alloc] initWithName:@"abc"];
    //    [[test1 children] addObject:[[Test alloc] initWithName:@"qwfp"]];
    //    [[test1 children] addObject:[[Test alloc] initWithName:@"jluy"]];
    //    [[test1 children] addObject:[[Test alloc] initWithName:@"cvbk"]];
    //    Test* test2 = [[Test alloc] initWithName:@"123"];
    //    [[test2 children] addObject:[[Test alloc] initWithName:@"4536"]];
    //    [[test2 children] addObject:[[Test alloc] initWithName:@"34087456098"]];
    //    [[test2 children] addObject:[[Test alloc] initWithName:@"11119999"]];
    //    [_tests addObject:test1];
    //    [_tests addObject:test2];

    NSArray* allNumValues = REFAllValuesInTestType();
    NSArray* allStringValues = [allNumValues oct_map:^NSString*(NSNumber* numType) {
      NSString* camelCaseString = REFStringForMemberInTestType([numType integerValue]);
        return [camelCaseString camelCaseToTitleCase];
    }];

    for(NSString* typeName in allStringValues)
    {
        [_tests addObject:[[Test alloc] initWithName:typeName]];
    }
}

#pragma mark - <NSOutlineViewDataSource>

- (NSInteger)outlineView:(NSOutlineView*)outlineView numberOfChildrenOfItem:(id)item
{
    if(!item)
    {
        return [_tests count];
    }
    else
    {
        return [[item children] count];
    }
}

- (BOOL)outlineView:(NSOutlineView*)outlineView isItemExpandable:(id)item
{
    if(!item)
    {
        return YES;
    }
    else
    {
        return [[item children] count] != 0;
    }
}

- (id)outlineView:(NSOutlineView*)outlineView child:(NSInteger)index ofItem:(id)item
{
    if(!item)
    {
        return [_tests objectAtIndex:index];
    }
    else
    {
        return [[item children] objectAtIndex:index];
    }
}

- (id)outlineView:(NSOutlineView*)outlineView objectValueForTableColumn:(NSTableColumn*)tableColumn byItem:(id)item
{
    //    if([[tableColumn identifier] isEqualToString:@"DataCell"])
    //    {
    return [item name];
    //        return [[NSCell alloc]initTextCell:@"arst"];
    //    }
    //    else
    //    {
    //        return @"Test";
    //        return [[NSCell alloc]initTextCell:@"arst"];
    //    }
}

#pragma mark - <NSOutlineViewDelegate>

- (nullable NSView*)outlineView:(nonnull NSOutlineView*)outlineView
             viewForTableColumn:(nullable NSTableColumn*)tableColumn
                           item:(nonnull id)item
{
    if([self outlineView:outlineView isGroupItem:item])
    {
        //        NSString *vId = [[[outlineView tableColumns] objectAtIndex:0] identifier];
        return [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    }
    return [outlineView makeViewWithIdentifier:[tableColumn identifier] owner:self];
}

- (BOOL)outlineView:(NSOutlineView*)outlineView isGroupItem:(id)item
{
    return [[item children] count] == 0;   //[item isKindOfClass:[ATDesktopFolderEntity class]];
}

- (void)outlineViewSelectionDidChange:(NSNotification*)notification
{
    //    NSLog(@"selected row: %lu", self.outlineView.selectedRow);
    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"TestNotification"
                      object:[NSNumber numberWithInteger:self.outlineView.selectedRow]];
}

@end
