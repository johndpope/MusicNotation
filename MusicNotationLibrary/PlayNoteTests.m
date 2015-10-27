//
//  PlayNoteTests.m
//  VexFlow
//
//  Created by Scott on 4/17/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

//#import "PlayNoteTests.h"
//#import "VexFlowTestHelpers.h"
//
//// http://theamazingaudioengine.com/doc/
//
//#import <TheAmazingAudioEngine.h>
//
//#import "AudioViewController.h"
//#import "ITSwitch.h"
//
//@interface PlayNoteTests ()
//@property (strong, nonatomic) NSMutableArray* cells;
//@property (strong, nonatomic) NSMutableArray* headers;
//@property (strong, nonatomic) AudioViewController* viewController;
//@end
//
//@implementation PlayNoteTests
//
//static AEAudioController* _audioController;
//// static AudioViewController* _viewController;
//
//- (void)start:(VFTestView*)parent;
//{
//    // Create an instance of the audio controller, set it up and start it running
//    _audioController = [[AEAudioController alloc]
//        initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription]
//                    inputEnabled:YES];
//    _audioController.preferredBufferDuration = 0.005;
//    _audioController.useMeasurementMode = YES;
//    [_audioController start:NULL];
//
//    _viewController = [[AudioViewController alloc] initWithAudioController:_audioController];
//
//    //    [super start:parent];
//    //    id targetClass = [self class];
//    //    [self runTest:@"basic"  func:@selector(basic:withTitle:)];
//
//    [self basic:parent withTitle:@"basic"];
//}
//
//static float sw_height = 20;
//static float sw_width = 20 * 1.618;
//
//- (void)basic:(VFTestView*)parent withTitle:(NSString*)title
//{
//    self.headers = [NSMutableArray array];
//    self.cells = [NSMutableArray array];
//
//    for(NSUInteger j = 0; j < [self numberOfSectionsInTableView:self]; ++j)
//    {
//        VFTestView* header =
//            [VFTestView createCanvasWithOutAdding:CGSizeMake(500, 50) withParent:parent withTitle:@"Header"];
//        header.backgroundColor = (VFColor*)[VFColor darkGrayColor];
//        [self.headers addObject:header];
//        for(NSUInteger k = 0; k < [self tableView:self numberOfRowsInSection:j]; ++k)
//        {
//            VFTestView* cell =
//                [VFTestView createCanvasWithOutAdding:CGSizeMake(500, 100) withParent:parent withTitle:title];
//            cell.backgroundColor = [VFColor randomBGColor:YES];
//            if(k == 0)
//            {
//                [self.cells addObject:[NSMutableArray array]];
//            }
//            [self.cells[j] addObject:cell];
//        }
//    }
//
//    for(NSUInteger j = 0; j < [self numberOfSectionsInTableView:self]; ++j)
//    {
//        VFTestView* header = [self tableView:self headerForSection:j];
//        [parent addSubview:header];
//        for(NSUInteger k = 0; k < [self tableView:self numberOfRowsInSection:j]; ++k)
//        {
//            VFTestView* cell = [self tableView:self cellForSection:j forRow:k];
//            [parent addSubview:cell];
//            [self tableView:self cellForSection:j forRow:k];
//        }
//    }
//    
//    [self.viewController load];
//}
//
//- (NSInteger)numberOfSectionsInTableView:(PlayNoteTests*)tableView
//{
//    return 4;
//}
//
//- (NSInteger)tableView:(PlayNoteTests*)tableView numberOfRowsInSection:(NSInteger)section
//{
//    switch(section)
//    {
//        case 0:
//            return 4;
//
//        case 1:
//            return 2;
//
//        case 2:
//            return 3;
//
//        case 3:
//            return 3 + (_audioController.numberOfInputChannels > 1 ? 1 : 0);
//
//        default:
//            return 0;
//    }
//}
//
//- (VFTestView*)tableView:(PlayNoteTests*)tableView headerForSection:(NSUInteger)section
//{
//    return [self.headers objectAtIndex:section];
//}
//
//- (VFTestView*)tableView:(PlayNoteTests*)tableView
//          cellForSection:(NSUInteger)section
//                  forRow:(NSUInteger)row   // IndexPath:(NSIndexPath*)indexPath
//{
//    VFTestView* cell = self.cells[section][row];
//
//    switch(section)
//    {
//        case 0:
//        {
//            //            cell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
//            //            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(cell.bounds.size.width - (isiPad
//            //            ? 250 :
//            //            210), 0, 100, cell.bounds.size.height)];
//            //            slider.autoresizingMask = NSViewAutoresizingFlexibleLeftMargin;
//            //            slider.tag = kAuxiliaryViewTag;
//            //            slider.maximumValue = 1.0;
//            //            slider.minimumValue = 0.0;
//            //            [cell addSubview:slider];
//            //
//            switch(row)
//            {
//                case 0:
//                {
//                    cell.title = @"Drums";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(loop1SwitchChanged:)];
//                    [cell addSubview:sw];
//
//                    //                    ((UISwitch*)cell.accessoryView).on = !_loop1.channelIsMuted;
//                    //                    slider.value = _loop1.volume;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(loop1SwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    //                    [slider addTarget:self action:@selector(loop1VolumeChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 1:
//                {
//                    cell.title = @"Organ";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(loop2SwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = !_loop2.channelIsMuted;
//                    //                    slider.value = _loop2.volume;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(loop2SwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    //                    [slider addTarget:self action:@selector(loop2VolumeChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 2:
//                {
//                    cell.title = @"Oscillator";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(oscillatorSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = !_oscillator.channelIsMuted;
//                    //                    slider.value = _oscillator.volume;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(oscillatorSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    //                    [slider addTarget:self action:@selector(oscillatorVolumeChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 3:
//                {
//                    cell.title = @"Group";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(channelGroupSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = ![_audioController
//                    //                    channelGroupIsMuted:_group];
//                    //                    slider.value = [_audioController volumeForChannelGroup:_group];
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(channelGroupSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    //                    [slider addTarget:self action:@selector(channelGroupVolumeChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    //                    break;
//                }
//            }
//            break;
//        }
//        case 1:
//        {
//            switch(row)
//            {
//                case 0:
//                {
//                    CGRect buttonFrame = CGRectMake(50, 50, 100, 30);
//                    VFButton* button = [[VFButton alloc] initWithFrame:buttonFrame];
//                    [button setButtonType:NSMomentaryLightButton];
//                    [button setBezelStyle:NSRoundedBezelStyle];
//                    [button setTitle:@"Play note"];
//                    [button setTarget:self.viewController];
//                    [button setAction:@selector(oneshotPlayButtonPressed:)];
//                    [cell addSubview:button];
//                    //                    cell.accessoryView = self.oneshotButton = [VFButton
//                    //                    buttonWithType:VFButtonTypeRoundedRect];
//                    //                    [_oneshotButton setTitle:@"Play" forState:UIControlStateNormal];
//                    //                    [_oneshotButton setTitle:@"Stop" forState:UIControlStateSelected];
//                    //                    [_oneshotButton sizeToFit];
//                    //                    [_oneshotButton setSelected:_oneshot != nil];
//                    //                    [_oneshotButton addTarget:self action:@selector(oneshotPlayButtonPressed:)
//                    //                    forControlEvents:UIControlEventTouchUpInside];
//                    //                    cell.title = @"One Shot";
//
//                    break;
//                }
//                case 1:
//                {
//                    CGRect buttonFrame = CGRectMake(50, 50, 100, 30);
//                    VFButton* button = [[VFButton alloc] initWithFrame:buttonFrame];
//                    [button setButtonType:NSMomentaryLightButton];
//                    [button setBezelStyle:NSRoundedBezelStyle];
//                    [button setTitle:@"Play note"];
//                    [button setTarget:self.viewController];
//                    [button setAction:@selector(oneshotAudioUnitPlayButtonPressed:)];
//                    [cell addSubview:button];
//                    //                    cell.accessoryView = self.oneshotAudioUnitButton = [VFButton
//                    //                    buttonWithType:VFButtonTypeRoundedRect];
//                    //                    [_oneshotAudioUnitButton setTitle:@"Play" forState:UIControlStateNormal];
//                    //                    [_oneshotAudioUnitButton setTitle:@"Stop" forState:UIControlStateSelected];
//                    //                    [_oneshotAudioUnitButton sizeToFit];
//                    //                    [_oneshotAudioUnitButton setSelected:_oneshot != nil];
//                    //                    [_oneshotAudioUnitButton addTarget:self
//                    //                    action:@selector(oneshotAudioUnitPlayButtonPressed:)
//                    //                    forControlEvents:UIControlEventTouchUpInside];
//                    //                    cell.title = @"One Shot (Audio Unit)";
//                    break;
//                }
//            }
//            break;
//        }
//        case 2:
//        {
//            //            cell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
//            //
//            switch(row)
//            {
//                case 0:
//                {
//                    cell.title = @"Limiter";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(limiterSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = _limiter != nil;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(limiterSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 1:
//                {
//                    cell.title = @"Expander";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(expanderSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = _expander != nil;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(expanderSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 2:
//                {
//                    cell.title = @"Reverb";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(reverbSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = _reverb != nil;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(reverbSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//            }
//            break;
//        }
//        case 3:
//        {
//            //            cell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
//            //
//            switch(row)
//            {
//                case 0:
//                {
//                    cell.title = @"Input Playthrough";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(playthroughSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = _playthrough != nil;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(playthroughSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 1:
//                {
//                    cell.title = @"Measurement Mode";
//                    ITSwitch* sw = [[ITSwitch alloc] initWithFrame:CGRectMake(50, 50, sw_width, sw_height)];
//                    [sw setTarget:self.viewController];
//                    [sw setAction:@selector(measurementModeSwitchChanged:)];
//                    [cell addSubview:sw];
//                    //                    ((UISwitch*)cell.accessoryView).on = _audioController.useMeasurementMode;
//                    //                    [((UISwitch*)cell.accessoryView) addTarget:self
//                    //                    action:@selector(measurementModeSwitchChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    break;
//                }
//                case 2:
//                {
//                    cell.title = @"Input Gain";
//                    CGRect buttonFrame = CGRectMake(50, 50, 100, 30);
//                    NSSlider* slider = [[NSSlider alloc] initWithFrame:buttonFrame];
//                    //                        [button setButtonType:NSMomentaryLightButton];
//                    //                        [button setBezelStyle:NSRoundedBezelStyle];
//                    //                        [slider setTitle:@"Play note"];
//                    [slider setTarget:self.viewController];
//                    [slider setAction:@selector(inputGainSliderChanged:)];
//                    [cell addSubview:slider];
//
//                    //                    UISlider *inputGainSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0,
//                    //                    100, 40)];
//                    //                    inputGainSlider.minimumValue = 0.0;
//                    //                    inputGainSlider.maximumValue = 1.0;
//                    //                    inputGainSlider.value = _audioController.inputGain;
//                    //                    [inputGainSlider addTarget:self action:@selector(inputGainSliderChanged:)
//                    //                    forControlEvents:UIControlEventValueChanged];
//                    //                    cell.accessoryView = inputGainSlider;
//                    break;
//                }
//                case 3:
//                {
//                    cell.title = @"Channels";
//                    //
//                    //                    int channelCount = _audioController.numberOfInputChannels;
//                    //                    CGSize buttonSize = CGSizeMake(30, 30);
//                    //
//                    //                    UIScrollView *channelStrip = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
//                    //                                                                                                0,
//                    //                                                                                                MIN(channelCount
//                    //                                                                                                *
//                    //                                                                                                (buttonSize.width+5)
//                    //                                                                                                +
//                    //                                                                                                5,
//                    //                                                                                                    isiPad ? 400 :
//                    //                                                                                                    200),
//                    //                                                                                                cell.bounds.size.height)];
//                    //                    channelStrip.autoresizingMask = NSViewAutoresizingFlexibleHeight |
//                    //                    NSViewAutoresizingFlexibleWidth;
//                    //                    channelStrip.backgroundColor = [UIColor clearColor];
//                    //
//                    //                    for ( int i=0; i<channelCount; i++ ) {
//                    //                        VFButton *button = [VFButton buttonWithType:VFButtonTypeRoundedRect];
//                    //                        button.frame = CGRectMake(i*(buttonSize.width+5),
//                    //                        round((channelStrip.bounds.size.height-buttonSize.height)/2),
//                    //                        buttonSize.width,
//                    //                        buttonSize.height);
//                    //                        [button setTitle:[NSString stringWithFormat:@"%d", i+1]
//                    //                        forState:UIControlStateNormal];
//                    //                        button.highlighted = [_audioController.inputChannelSelection
//                    //                        containsObject:@(i)];
//                    //                        button.tag = i;
//                    //                        [button addTarget:self action:@selector(channelButtonPressed:)
//                    //                        forControlEvents:UIControlEventTouchUpInside];
//                    //                        [channelStrip addSubview:button];
//                    //                    }
//                    //
//                    //                    channelStrip.contentSize = CGSizeMake(channelCount * (buttonSize.width+5) + 5,
//                    //                    channelStrip.bounds.size.height);
//                    //
//                    //                    cell.accessoryView = channelStrip;
//                    //
//                    break;
//                }
//            }
//            break;
//        }
//    }
//
//    return cell;
//}
//
////- (IBAction)switchChanged:(ITSwitch*)itSwitch
////{
////    NSLog(@"Switch (%@) is %@", itSwitch, itSwitch.isOn ? @"enabled" : @"disabled");
////}
////
////- (void)playNote:(VFButton*)sender
////{
////    [VFLog logInfo:@"play note"];
////}
//
//@end
