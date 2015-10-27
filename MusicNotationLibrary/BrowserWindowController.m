//
//  ViewController.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "BrowserWindowController.h"
//#import "DDLog.h"
//#import "DDASLLogger.h"
//#import "DDTTYLogger.h"
//#import "DDFileLogger.h"
//#import <AFNetworking/AFNetworking.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <CocoaLumberjack/CocoaLumberjack.h>

#import "Tests.h"
#import "WrappedLayout.h"
#import "TestCollectionItem.h"
#import "NSString+Additions.h"

//======================================================================================================================

@interface BrowserWindowController () <NSSplitViewDelegate>

@property (strong, nonatomic) NSDictionary* classForType;
@property (strong, nonatomic) TestViewController* testViewController;
//@property (strong, nonatomic) NSSplitViewController* splitViewController;
@property (strong) IBOutlet NSSplitViewController* splitViewController;

@end

@implementation BrowserWindowController

- (instancetype)init
{
    self = [super initWithWindowNibName:@"BrowserWindow"];
    self = [super init];   // WithCoder:coder];
    if(self)
    {
        //        static const int ddLogLevel = LOG_LEVEL_ALL;

        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveTestNotification:)
                                                     name:@"TestNotification"
                                                   object:nil];

        //        [_toolbar setAllowsUserCustomization:NO];
        //        [_toolbar setDisplayMode:NSToolbarDisplayModeIconOnly];
    }
    return self;
}

- (void)dealloc
{
    //    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    // FIXME: this doesn't appear to work
    [_collectionView registerClass:[TestCollectionItem class] forItemWithIdentifier:kTestCollectionItemid];

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    self.testType =
        [defaults objectForKey:@"lastTest"] ? [[defaults objectForKey:@"lastTest"] integerValue] : AccidentalTestType;

    // temporary override
    //    self.testType = AccidentalTestType;

    [self loadTest:self.testType];

    //    _splitView.delegate = self;

    [_collectionView setBackgroundColors:[NSArray arrayWithObjects:[NSColor underPageBackgroundColor], nil]];

    //    CGRect oldBounds = _collectionView.enclosingScrollView.contentView.bounds;
    //    _collectionView.enclosingScrollView.contentView.bounds = CGRectMake(0, 0, oldBounds.size.width,
    //    oldBounds.size.height);

    //    _collectionView.enclosingScrollView.hasHorizontalScroller = YES;
    //    _collectionView.enclosingScrollView.hasVerticalScroller = YES;
    //    _collectionView.enclosingScrollView.allowsMagnification = YES;
    //    _collectionView.enclosingScrollView.maxMagnification = 2;
    //    _collectionView.enclosingScrollView.minMagnification = 0.5;
    //    _collectionView.enclosingScrollView.magnification = 1.0;

    //    _splitViewController.splitView = _splitView;
    //    _splitViewController.splitViewItems
    ((NSButton*)_showHideToolbarButton.view).title = @"Hide";
}

//- (NSSplitViewController*)splitViewController
//{
//    if(!_splitViewController)
//    {
//        _splitViewController = [[NSSplitViewController alloc] init];
//        _splitViewController.splitView = _splitView;
//    }
//    return _splitViewController;
//}

- (void)receiveTestNotification:(NSNotification*)notification
{
    if([[notification name] isEqualToString:@"TestNotification"])
    {
        [self loadTest:[((NSNumber*)notification.object)integerValue]];
    }
}

- (NSDictionary*)classForType
{
    if(!_classForType)
    {
        _classForType = @{
            @(NoneTestType) : [NSNull null],
            @(AccidentalTestType) : [AccidentalTests class],
            @(AnimationTestType) : [NSNull null],
            @(AnnotationTestType) : [AnnotationTests class],
            @(ArticulationTestType) : [ArticulationTests class],
            @(AutoBeamFormattingTestType) : [AutoBeamFormattingTests class],
            @(BeamTestType) : [BeamTests class],
            @(BendTestType) : [BendTests class],
            @(BoundingBoxTestType) : [BoundingBoxTests class],
            @(ClefTestType) : [ClefTests class],
            @(CurveTestType) : [CurveTests class],
            @(DotTestType) : [DotTests class],
            @(EveryThingTestType) : [NSNull null],
            @(FormatterTestType) : [FormatterTests class],
            @(GraceNoteTestType) : [GraceNoteTests class],
            @(InfiniteScrollTestType) : [NSNull null],
            @(KeyClefTestType) : [KeyClefTests class],
            @(KeyManagerTestType) : [KeyManagerTests class],
            @(KeySignatureTestType) : [KeySignatureTests class],
            @(LayerNoteTestsTestType) : [LayerNoteTests class],
            @(MocksType) : [NSNull null],
            @(ModifierTestType) : [NSNull null],
            @(MusicTestType) : [NSNull null],
            @(NodeTestType) : [NSNull null],
            @(NoteHeadTestType) : [NoteHeadTests class],
            @(NotationsGridClassicTestType) : [NotationsGridTests class],
            @(NotationsCollectionTestsType) : [NotationsCollectionTests class],
            @(NotationsGridTestType) : [NotationsGridTests class],
            @(OrnamentTestType) : [OrnamentTests class],
            @(ParseTestType) : [NSNull null],
            @(PedalMarkingTestType) : [PedalMarkingTests class],
            @(PercussionTestType) : [PercussionTests class],
            @(PlayNoteTestType) : [NSNull null],
            @(RefreshAnimationTestType) : [NSNull null],
            @(RestsTestType) : [RestsTest class],
            @(RhythmTestType) : [RhythmTests class],
            @(ScrollViewTestType) : [NSNull null],
            @(StaffTestType) : [StaffTests class],
            @(StaffConnectorTestType) : [StaffConnectorTests class],
            @(StaffHairpinTestType) : [StaffHairpinTests class],
            @(StaffLineTestType) : [StaffLineTests class],
            @(StaffModifierTestType) : [StaffModifierTests class],
            @(StaffNoteTestType) : [StaffNoteTests class],
            @(StaffTieTestType) : [StaffTieTests class],
            @(StringNumberTestType) : [StringNumberTests class],
            @(StrokesTestType) : [StrokesTests class],
            @(TableTestType) : [TableTests class],
            @(TabNoteTestType) : [TabNoteTests class],
            @(TabSlideTestType) : [TabSlideTests class],
            @(TabStaffTestType) : [TabStaffTests class],
            @(TabTieTestType) : [TabTieTests class],
            @(TextBracketTestType) : [TextBracketTests class],
            @(TextNoteTestType) : [TextNoteTests class],
            @(TextTestType) : [TextTests class],
            @(ThreeVoiceTestType) : [ThreeVoiceTests class],
            @(TickContextTestType) : [TickContextTests class],
            @(TimeSignatureTestType) : [TimeSignatureTests class],
            @(TransformTestType) : [NSNull null],
            @(TuningTestType) : [TuningTests class],
            @(TupletTestType) : [TupletTests class],
            @(VibratoTestType) : [VibratoTests class],
            @(VoiceTestType) : [VoiceTests class],
        };
        NSArray* allNumValues = REFAllValuesInTestType();
        if(allNumValues.count != _classForType.count)
        {
            NSLog(@"%@:%lu out of sync with %@:%lu", VariableName(_classForType), _classForType.count,
                  VariableName(self.testType), allNumValues.count);
            NSMutableSet *set1, *set2;
            set1 = [[NSMutableSet alloc] init];
            [set1 addObjectsFromArray:allNumValues];
            set2 = [[NSMutableSet alloc] init];
            [set2 addObjectsFromArray:_classForType.allKeys];
            [set1 minusSet:set2];
            for(NSNumber* num in set1)
            {
                TestType missingType = [num integerValue];
                NSString* missingTypeString = REFStringForMemberInTestType(missingType);
                if([missingTypeString isNotEqualToString:@""])
                {
                    NSLog(@"missing class for type: %@", missingTypeString);
                }
            }
        }
    }

    return _classForType;
}

- (void)loadTest:(TestType)testType
{
    _testType = testType;

    NSMutableString* windowTitleString = [NSMutableString stringWithFormat:@" Running : "];
    [windowTitleString appendString:[REFStringForMemberInTestType(_testType) camelCaseToTitleCase]];

    ((NSTextField*)windowTitleToolbarItem.view).stringValue = windowTitleString;

    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(_testType) forKey:@"lastTest"];
    [defaults synchronize];

    if([self.classForType objectForKey:@(_testType)] != [NSNull null])
    {
        Class clazz = [self.classForType objectForKey:@(_testType)];
        if([clazz isSubclassOfClass:[TestViewController class]])
        {
            self.testViewController = [[clazz alloc] init];
            [self.testViewController start];
            _collectionView.delegate = self.testViewController;
            _collectionView.dataSource = self.testViewController;
            //            ((NSScrollView*)_collectionView.superview).allowsMagnification = YES;

            WrappedLayout* layout = [[WrappedLayout alloc] init];
            layout.collectionView.delegate = self;
            layout.testViewController = self.testViewController;
            _collectionView.collectionViewLayout = layout;
        }
        else
        {
            // handle other test type...
        }
    }
}

#pragma mark - <NSToolbarDelegate>

- (IBAction)showHide:(NSToolbarItem*)sender
{
    NSButton* button = (NSButton*)sender;

    //    NSView* subView = [_splitView.subviews objectAtIndex:0];

    if([button.title isEqualToString:@"Show"])   // state == NSOnState)
    {
        //        button.state = NSOffState;
        [[self.splitViewController.splitViewItems[0] animator] setCollapsed:NO];
        button.title = @"Hide";
    }
    else if([button.title isEqualToString:@"Hide"])   // state == NSOffState)
    {
        //        button.state = NSOnState;
        [[self.splitViewController.splitViewItems[0] animator] setCollapsed:YES];
        button.title = @"Show";
    }
}

#pragma mark - <NSSplitViewDelegate>

//- (CGFloat)splitView:(NSSplitView*)splitView
//    constrainMinCoordinate:(CGFloat)proposedMinimumPosition
//               ofSubviewAt:(NSInteger)dividerIndex
//{
//    if(dividerIndex == 0)
//    {
//        return proposedMinimumPosition + 100;
//    }
//    return proposedMinimumPosition;
//}

//#pragma mark NSCollectionViewDataSource Methods
//
//- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView*)collectionView
//{
//    return [self.testViewController numberOfSectionsInCollectionView:collectionView];
//}
//
//- (NSInteger)collectionView:(NSCollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return [self.testViewController collectionView:collectionView numberOfItemsInSection:section];
//}
//
//- (NSCollectionViewItem*)collectionView:(NSCollectionView*)collectionView
//    itemForRepresentedObjectAtIndexPath:(NSIndexPath*)indexPath
//{
//    return nil;
//}
//
//- (nonnull NSView*)collectionView:(nonnull NSCollectionView*)collectionView
// viewForSupplementaryElementOfKind:(nonnull NSString*)kind
//                      atIndexPath:(nonnull NSIndexPath*)indexPath
//{
//    return nil;
//}
//
//#pragma mark NSCollectionViewDelegateFlowLayout Methods
//
//- (NSSize)collectionView:(NSCollectionView*)collectionView
//                             layout:(NSCollectionViewLayout*)collectionViewLayout
//    referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return NSSizeFromCGSize(CGSizeZero);
//}
//
//- (NSSize)collectionView:(NSCollectionView*)collectionView
//                             layout:(NSCollectionViewLayout*)collectionViewLayout
//    referenceSizeForFooterInSection:(NSInteger)section
//{
//    return NSSizeFromCGSize(CGSizeZero);
//}
//
//#pragma mark NSCollectionViewDelegate

@end
