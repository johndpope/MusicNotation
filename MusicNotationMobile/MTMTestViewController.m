//
//  MTMTestViewController.m
//  MusicApp
//
//  Created by Scott on 8/1/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "MTMTestViewController.h"
#import "Tests.h"
//#import "MTMTestView.h"

@interface MTMTestViewController ()   //<UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) MTMTestView* testView;
@property (strong, nonatomic) TestViewController* testViewController;
@end

@implementation MTMTestViewController

//- (instancetype)initWithTestType:(TestType)testType
//{
//    self = [super init];
//    if(self)
//    {
//    }
//    return self;
//}

- (void)viewDidLoad
{
    UIView* view = nil;

    switch(self.testType)
    {
        //        case EveryThingTestType:
        //            [self everyThing];
        //            break;
        case NoneTestType:
            NSLog(@"no test loaded");
            break;
        case AccidentalTestType:
            self.testViewController = [[AccidentalTests alloc] init];
            break;
        case AnimationTestType:
            //            self.testViewController = [[AnimationTests alloc] init];
            break;
        case AnnotationTestType:
            self.testViewController = [[AnnotationTests alloc] init];
            break;
        case ArticulationTestType:
            self.testViewController = [[ArticulationTests alloc] init];
            break;
        case AutoBeamFormattingTestType:
            self.testViewController = [[AutoBeamFormattingTests alloc] init];
            //            {
            //                AutoBeamFormattingTests* test = [[AutoBeamFormattingTests alloc] init];
            //                self.currentTest = test;
            //                [test start:view];
            //            }
            break;
        case BeamTestType:
            self.testViewController = [[BeamTests alloc] init];
            break;
        case BendTestType:
            self.testViewController = [[BendTests alloc] init];
            break;
        case BoundingBoxTestType:
            self.testViewController = [[BoundingBoxTests alloc] init];
            break;
        case ClefTestType:
            self.testViewController = [[ClefTests alloc] init];
            break;
        case CurveTestType:
            self.testViewController = [[CurveTests alloc] init];
            break;
        case DotTestType:
            self.testViewController = [[DotTests alloc] init];
            break;
        case FormatterTestType:
            self.testViewController = [[FormatterTests alloc] init];
            break;
        case GraceNoteTestType:
            self.testViewController = [[GraceNoteTests alloc] init];
            break;
        case InfiniteScrollTestType:
            [VFLog logError:@"InfiniteScrollTestType not yet implemented"];
            break;
        case KeyClefTestType:
            self.testViewController = [[KeyClefTests alloc] init];
            break;
        case KeyManagerTestType:
            self.testViewController = [[KeyManagerTests alloc] init];
            break;
        case KeySignatureTestType:
            self.testViewController = [[KeySignatureTests alloc] init];
            break;
        //        case MocksType:
        //        [Mocks start:view];
        //            break;
        case ModifierTestType:
            self.testViewController = [[ModifierTests alloc] init];
            break;
        case MusicTestType:
            self.testViewController = [[MusicTests alloc] init];
            break;
        case NodeTestType:
            self.testViewController = [[NodeTests alloc] init];
            break;
        case NoteHeadTestType:
            self.testViewController = [[NoteHeadTests alloc] init];
            break;
        case NotationsGridTestType:
            self.testViewController = [[NotationsGrid alloc] init];
            break;
        case OrnamentTestType:
            self.testViewController = [[OrnamentTests alloc] init];
            break;
        case ParseTestType:
            self.testViewController = [[ParserTests alloc] init];
            break;
        case PedalMarkingTestType:
            self.testViewController = [[PedalMarkingTests alloc] init];
            break;
        case PercussionTestType:
            self.testViewController = [[PercussionTests alloc] init];
            break;
        case PlayNoteTestType:
            //            [PlayNoteTests start:view];
            {
                //                PlayNoteTests* test = [[PlayNoteTests alloc] init];
                //                self.currentTest = test;
                //                [test start:view];
            }
            break;
        case RefreshAnimationTestType:
            self.testViewController = [[RefreshAnimationTest alloc] init];
            break;
        case RestsTestType:
            self.testViewController = [[RestsTest alloc] init];
            break;
        case RhythmTestType:
            self.testViewController = [[RhythmTests alloc] init];
            break;
        case ScrollViewTestType:
            //            self.testViewController = [[ScrollViewTests alloc] init];
            break;
        case StaffTestType:
            self.testViewController = [[StaffTests alloc] init];
            break;
        case StaffConnectorTestType:
            self.testViewController = [[StaffConnectorTests alloc] init];
            break;
        case StaffHairpinTestType:
            self.testViewController = [[StaffHairpinTests alloc] init];
            break;
        case StaffLineTestType:
            self.testViewController = [[StaffLineTests alloc] init];
            break;
        case StaffModifierTestType:
            self.testViewController = [[StaffModifierTests alloc] init];
            break;
        case StaffNoteTestType:
            self.testViewController = [[StaffNoteTests alloc] init];
            break;
        case StaffTieTestType:
            self.testViewController = [[StaffTieTests alloc] init];
            break;
        case StringNumberTestType:
            self.testViewController = [[StringNumberTests alloc] init];
            break;
        case StrokesTestType:
            self.testViewController = [[StrokesTests alloc] init];
            break;
        case TableTestType:
            self.testViewController = [[TableTests alloc] init];
            break;
        case TabNoteTestType:
            self.testViewController = [[TabNoteTests alloc] init];
            break;
        case TabSlideTestType:
            self.testViewController = [[TabSlideTests alloc] init];
            break;
        case TabStaffTestType:
            self.testViewController = [[TabStaffTests alloc] init];
            break;
        case TabTieTestType:
            self.testViewController = [[TabTieTests alloc] init];
            break;
        case TextBracketTestType:
            self.testViewController = [[TextBracketTests alloc] init];
            break;
        case TextNoteTestType:
            self.testViewController = [[TextNoteTests alloc] init];
            break;
        case TextTestType:
            self.testViewController = [[TextTests alloc] init];
            break;
        case ThreeVoiceTestType:
            self.testViewController = [[ThreeVoiceTests alloc] init];
            break;
        case TickContextTestType:
            self.testViewController = [[TickContextTests alloc] init];
            break;
        case TimeSignatureTestType:
            self.testViewController = [[TimeSignatureTests alloc] init];
            break;
        case TransformTestType:
            //            self.testViewController = [[TransformTests alloc] init];
            break;
        case TuningTestType:
            self.testViewController = [[TuningTests alloc] init];
            break;
        case TupletTestType:
            self.testViewController = [[TupletTests alloc] init];
            break;
        case VibratoTestType:
            self.testViewController = [[VibratoTests alloc] init];
            break;
        case VoiceTestType:
            self.testViewController = [[VoiceTests alloc] init];
            break;
        default:
            break;
    }

    [self.testViewController start];
    self.tableView.dataSource = self.testViewController;
    self.tableView.delegate = self.testViewController;
}

@end
