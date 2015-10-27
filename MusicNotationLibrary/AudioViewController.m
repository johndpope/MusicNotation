////
////  AudioViewController.m
////  VexFlow
////
////  Created by Scott on 6/8/15.
////  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
////
//
//#import "AudioViewController.h"
//
//#import "ViewController.h"
//#import "TheAmazingAudioEngine.h"
//#import "TPOscilloscopeLayer.h"
//#import "AEPlaythroughChannel.h"
////#import <TheAmazingAudioEngine/Modules/AEPlaythroughChannel.h>
//#import "AEExpanderFilter.h"
//#import "AELimiterFilter.h"
//#import "AERecorder.h"
//#import <QuartzCore/QuartzCore.h>
//#import "ITSwitch.h"
//
//#define checkResult(result, operation) (_checkResult((result), (operation), strrchr(__FILE__, '/') + 1, __LINE__))
//static inline BOOL _checkResult(OSStatus result, const char* operation, const char* file, int line)
//{
//    if(result != noErr)
//    {
//        int fourCC = CFSwapInt32HostToBig(result);
//        NSLog(@"%s:%d: %s result %d %08X %4.4s\n", file, line, operation, (int)result, (int)result, (char*)&fourCC);
//        return NO;
//    }
//    return YES;
//}
//
//static const int kInputChannelsChangedContext;
//
//#define kAuxiliaryViewTag 251
//
//@interface AudioViewController ()
//{
//    AudioFileID _audioUnitFile;
//    AEChannelGroupRef _group;
//}
//@property (nonatomic, strong) AEAudioController* audioController;
//@property (nonatomic, strong) AEAudioFilePlayer* loop1;
//@property (nonatomic, strong) AEAudioFilePlayer* loop2;
//@property (nonatomic, strong) AEBlockChannel* oscillator;
//@property (nonatomic, strong) AEAudioUnitChannel* audioUnitPlayer;
//@property (nonatomic, strong) AEAudioFilePlayer* oneshot;
//@property (nonatomic, strong) AEPlaythroughChannel* playthrough;
//@property (nonatomic, strong) AELimiterFilter* limiter;
//@property (nonatomic, strong) AEExpanderFilter* expander;
//@property (nonatomic, strong) AEAudioUnitFilter* reverb;
//@property (nonatomic, strong) TPOscilloscopeLayer* outputOscilloscope;
//@property (nonatomic, strong) TPOscilloscopeLayer* inputOscilloscope;
//@property (nonatomic, strong) CALayer* inputLevelLayer;
//@property (nonatomic, strong) CALayer* outputLevelLayer;
//@property (nonatomic, weak) NSTimer* levelsTimer;
//@property (nonatomic, strong) AERecorder* recorder;
//@property (nonatomic, strong) AEAudioFilePlayer* player;
//@property (nonatomic, strong) VFButton* recordButton;
//@property (nonatomic, strong) VFButton* playButton;
//@property (nonatomic, strong) VFButton* oneshotButton;
//@property (nonatomic, strong) VFButton* oneshotAudioUnitButton;
//@end
//
//@implementation AudioViewController
//
//- (id)initWithAudioController:(AEAudioController*)audioController
//{
//    //    if ( !(self = [super initWithStyle:NSTableViewStyleGrouped]) ) return nil;
//    if(!(self = [super init]))
//        return nil;
//
//    self.audioController = audioController;
//
////    // Create the first loop player
////    self.loop1 = [AEAudioFilePlayer
////        audioFilePlayerWithURL:[[NSBundle mainBundle] URLForResource:@"Southern Rock Drums" withExtension:@"m4a"]
////               audioController:_audioController
////                         error:NULL];
////    _loop1.volume = 1.0;
////    _loop1.channelIsMuted = YES;
////    _loop1.loop = YES;
////
////    // Create the second loop player
////    self.loop2 = [AEAudioFilePlayer
////        audioFilePlayerWithURL:[[NSBundle mainBundle] URLForResource:@"Southern Rock Organ" withExtension:@"m4a"]
////               audioController:_audioController
////                         error:NULL];
////    _loop2.volume = 1.0;
////    _loop2.channelIsMuted = YES;
////    _loop2.loop = YES;
//
//    // Create a block-based channel, with an implementation of an oscillator
//    __block float oscillatorPosition = 0;
//    __block float oscillatorRate = 622.0 / 44100.0;
//    self.oscillator =
//        [AEBlockChannel channelWithBlock:^(const AudioTimeStamp* time, UInt32 frames, AudioBufferList* audio) {
//          for(int i = 0; i < frames; i++)
//          {
//              // Quick sin-esque oscillator
//              float x = oscillatorPosition;
//              x *= x;
//              x -= 1.0;
//              x *= x;   // x now in the range 0...1
//              x *= INT16_MAX;
//              x -= INT16_MAX / 2;
//              oscillatorPosition += oscillatorRate;
//              if(oscillatorPosition > 1.0)
//                  oscillatorPosition -= 2.0;
//
//              ((SInt16*)audio->mBuffers[0].mData)[i] = x;
//              ((SInt16*)audio->mBuffers[1].mData)[i] = x;
//          }
//        }];
//    _oscillator.audioDescription = [AEAudioController nonInterleaved16BitStereoAudioDescription];
//
//    _oscillator.channelIsMuted = YES;
//
//    // Create an audio unit channel (a file player)
//    self.audioUnitPlayer = [[AEAudioUnitChannel alloc]
//        initWithComponentDescription:AEAudioComponentDescriptionMake(kAudioUnitManufacturer_Apple,
//                                                                     kAudioUnitType_Generator,
//                                                                     kAudioUnitSubType_AudioFilePlayer)
//                     audioController:_audioController
//                               error:NULL];
//
//    //    // Create a group for loop1, loop2 and oscillator
//    //    _group = [_audioController createChannelGroup];
//    //    [_audioController addChannels:@[_loop1, _loop2, _oscillator] toChannelGroup:_group];
//    //
//    //    // Finally, add the audio unit player
//    //    [_audioController addChannels:@[_audioUnitPlayer]];
//    //
//    //    [_audioController addObserver:self forKeyPath:@"numberOfInputChannels" options:0
//    //    context:(void*)&kInputChannelsChangedContext];
//    //
//    return self;
//}
//
//- (void)dealloc
//{
//    [_audioController removeObserver:self forKeyPath:@"numberOfInputChannels"];
//
//    if(_levelsTimer)
//        [_levelsTimer invalidate];
//
//    NSMutableArray* channelsToRemove = [NSMutableArray arrayWithObjects:_loop1, _loop2, nil];
//
//    if(_player)
//    {
//        [channelsToRemove addObject:_player];
//    }
//
//    if(_oneshot)
//    {
//        [channelsToRemove addObject:_oneshot];
//    }
//
//    if(_playthrough)
//    {
//        [channelsToRemove addObject:_playthrough];
//        [_audioController removeInputReceiver:_playthrough];
//    }
//
//    [_audioController removeChannels:channelsToRemove];
//
//    if(_limiter)
//    {
//        [_audioController removeFilter:_limiter];
//    }
//
//    if(_expander)
//    {
//        [_audioController removeFilter:_expander];
//    }
//
//    if(_reverb)
//    {
//        [_audioController removeFilter:_reverb];
//    }
//
//    if(_audioUnitFile)
//    {
//        AudioFileClose(_audioUnitFile);
//    }
//}
//
//- (void)load
//{
//    //    [super viewDidLoad];
//    //
//    //    NSView *headerView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 100)];
//    //    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    //
//    //    self.outputOscilloscope = [[TPOscilloscopeLayer alloc] initWithAudioController:_audioController];
//    //    _outputOscilloscope.frame = CGRectMake(0, 0, headerView.bounds.size.width, 80);
//    //    [headerView.layer addSublayer:_outputOscilloscope];
//    //    [_audioController addOutputReceiver:_outputOscilloscope];
//    //    [_outputOscilloscope start];
//    //
//    //    self.inputOscilloscope = [[TPOscilloscopeLayer alloc] initWithAudioController:_audioController];
//    //    _inputOscilloscope.frame = CGRectMake(0, 0, headerView.bounds.size.width, 80);
//    //    _inputOscilloscope.lineColor = [UIColor colorWithWhite:0.0 alpha:0.3];
//    //    [headerView.layer addSublayer:_inputOscilloscope];
//    //    [_audioController addInputReceiver:_inputOscilloscope];
//    //    [_inputOscilloscope start];
//    //
//    //    self.inputLevelLayer = [CALayer layer];
//    //    _inputLevelLayer.backgroundColor = [[UIColor colorWithWhite:0.0 alpha:0.3] CGColor];
//    //    _inputLevelLayer.frame = CGRectMake(headerView.bounds.size.width/2.0 - 5.0 - (0.0), 90, 0, 10);
//    //    [headerView.layer addSublayer:_inputLevelLayer];
//    //
//    //    self.outputLevelLayer = [CALayer layer];
//    //    _outputLevelLayer.backgroundColor = [[UIColor colorWithWhite:0.0 alpha:0.3] CGColor];
//    //    _outputLevelLayer.frame = CGRectMake(headerView.bounds.size.width/2.0 + 5.0, 90, 0, 10);
//    //    [headerView.layer addSublayer:_outputLevelLayer];
//    //
//    //    self.tableView.tableHeaderView = headerView;
//    //
//    //    NSView *footerView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 80)];
//    //    self.recordButton = [VFButton buttonWithType:VFButtonTypeRoundedRect];
//    //    [_recordButton setTitle:@"Record" forState:UIControlStateNormal];
//    //    [_recordButton setTitle:@"Stop" forState:UIControlStateSelected];
//    //    [_recordButton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
//    //    _recordButton.frame = CGRectMake(20, 10, ((footerView.bounds.size.width-50) / 2),
//    //    footerView.bounds.size.height -
//    //    20);
//    //    _recordButton.autoresizingMask = NSViewAutoresizingFlexibleWidth | NSViewAutoresizingFlexibleRightMargin;
//    //    self.playButton = [VFButton buttonWithType:VFButtonTypeRoundedRect];
//    //    [_playButton setTitle:@"Play" forState:UIControlStateNormal];
//    //    [_playButton setTitle:@"Stop" forState:UIControlStateSelected];
//    //    [_playButton addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
//    //    _playButton.frame = CGRectMake(CGRectGetMaxX(_recordButton.frame)+10, 10, ((footerView.bounds.size.width-50) /
//    //    2),
//    //    footerView.bounds.size.height - 20);
//    //    _playButton.autoresizingMask = NSViewAutoresizingFlexibleWidth | NSViewAutoresizingFlexibleLeftMargin;
//    //    [footerView addSubview:_recordButton];
//    //    [footerView addSubview:_playButton];
//    //    self.tableView.tableFooterView = footerView;
//}
//
////-(void)viewWillAppear:(BOOL)animated {
////    [super viewWillAppear:animated];
////    self.levelsTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateLevels:)
////    userInfo:nil repeats:YES];
////}
//
////-(void)viewWillDisappear:(BOOL)animated {
////    [super viewWillDisappear:animated];
////    [_levelsTimer invalidate];
////    self.levelsTimer = nil;
////}
//
////-(void)viewDidLayoutSubviews {
////    _outputOscilloscope.frame = CGRectMake(0, 0, self.tableView.tableHeaderView.bounds.size.width, 80);
////    _inputOscilloscope.frame = CGRectMake(0, 0, self.tableView.tableHeaderView.bounds.size.width, 80);
////}
//
//- (void)loop1SwitchChanged:(ITSwitch*)sender
//{
//    _loop1.channelIsMuted = !sender.isOn;
//}
//
//- (void)loop1VolumeChanged:(NSSlider*)sender
//{
//    //    _loop1.volume = sender.value;
//}
//
//- (void)loop2SwitchChanged:(ITSwitch*)sender
//{
//    _loop2.channelIsMuted = !sender.isOn;
//}
//
//- (void)loop2VolumeChanged:(NSSlider*)sender
//{
//    //    _loop2.volume = sender.value;
//}
//
//- (void)oscillatorSwitchChanged:(ITSwitch*)sender
//{
//    _oscillator.channelIsMuted = !sender.isOn;
//}
//
//- (void)oscillatorVolumeChanged:(NSSlider*)sender
//{
//    //    _oscillator.volume = sender.value;
//}
//
//- (void)channelGroupSwitchChanged:(ITSwitch*)sender
//{
//    [_audioController setMuted:!sender.isOn forChannelGroup:_group];
//}
//
//- (void)channelGroupVolumeChanged:(NSSlider*)sender
//{
//    //    [_audioController setVolume:sender.value forChannelGroup:_group];
//}
//
//- (void)oneshotPlayButtonPressed:(VFButton*)sender
//{
//    if(_oneshot)
//    {
//        [_audioController removeChannels:@[ _oneshot ]];
//        self.oneshot = nil;
//        //        _oneshotButton.selected = NO;
//    }
//    else
//    {
//        self.oneshot = [AEAudioFilePlayer
//            audioFilePlayerWithURL:[[NSBundle mainBundle] URLForResource:@"Organ Run" withExtension:@"m4a"]
//                   audioController:_audioController
//                             error:NULL];
//        _oneshot.removeUponFinish = YES;
//        //        __weak ViewController *weakSelf = self;
//        _oneshot.completionBlock = ^{
//          //            ViewController *strongSelf = weakSelf;
//          //            strongSelf.oneshot = nil;
//          //            strongSelf->_oneshotButton.selected = NO;
//        };
//        [_audioController addChannels:@[ _oneshot ]];
//        //        _oneshotButton.selected = YES;
//    }
//}
//
//- (void)oneshotAudioUnitPlayButtonPressed:(VFButton*)sender
//{
//    if(!_audioUnitFile)
//    {
//        NSURL* playerFile = [[NSBundle mainBundle] URLForResource:@"Organ Run" withExtension:@"m4a"];
//        checkResult(AudioFileOpenURL((__bridge CFURLRef)playerFile, kAudioFileReadPermission, 0, &_audioUnitFile),
//                    "AudioFileOpenURL");
//    }
//
//    // Set the file to play
//    checkResult(AudioUnitSetProperty(_audioUnitPlayer.audioUnit, kAudioUnitProperty_ScheduledFileIDs,
//                                     kAudioUnitScope_Global, 0, &_audioUnitFile, sizeof(_audioUnitFile)),
//                "AudioUnitSetProperty(kAudioUnitProperty_ScheduledFileIDs)");
//
//    // Determine file properties
//    UInt64 packetCount;
//    UInt32 size = sizeof(packetCount);
//    checkResult(AudioFileGetProperty(_audioUnitFile, kAudioFilePropertyAudioDataPacketCount, &size, &packetCount),
//                "AudioFileGetProperty(kAudioFilePropertyAudioDataPacketCount)");
//
//    AudioStreamBasicDescription dataFormat;
//    size = sizeof(dataFormat);
//    checkResult(AudioFileGetProperty(_audioUnitFile, kAudioFilePropertyDataFormat, &size, &dataFormat),
//                "AudioFileGetProperty(kAudioFilePropertyDataFormat)");
//
//    // Assign the region to play
//    ScheduledAudioFileRegion region;
//    memset(&region.mTimeStamp, 0, sizeof(region.mTimeStamp));
//    region.mTimeStamp.mFlags = kAudioTimeStampSampleTimeValid;
//    region.mTimeStamp.mSampleTime = 0;
//    region.mCompletionProc = NULL;
//    region.mCompletionProcUserData = NULL;
//    region.mAudioFile = _audioUnitFile;
//    region.mLoopCount = 0;
//    region.mStartFrame = 0;
//    region.mFramesToPlay = (UInt32)packetCount * dataFormat.mFramesPerPacket;
//    checkResult(AudioUnitSetProperty(_audioUnitPlayer.audioUnit, kAudioUnitProperty_ScheduledFileRegion,
//                                     kAudioUnitScope_Global, 0, &region, sizeof(region)),
//                "AudioUnitSetProperty(kAudioUnitProperty_ScheduledFileRegion)");
//
//    // Prime the player by reading some frames from disk
//    UInt32 defaultNumberOfFrames = 0;
//    checkResult(AudioUnitSetProperty(_audioUnitPlayer.audioUnit, kAudioUnitProperty_ScheduledFilePrime,
//                                     kAudioUnitScope_Global, 0, &defaultNumberOfFrames, sizeof(defaultNumberOfFrames)),
//                "AudioUnitSetProperty(kAudioUnitProperty_ScheduledFilePrime)");
//
//    // Set the start time (now = -1)
//    AudioTimeStamp startTime;
//    memset(&startTime, 0, sizeof(startTime));
//    startTime.mFlags = kAudioTimeStampSampleTimeValid;
//    startTime.mSampleTime = -1;
//    checkResult(AudioUnitSetProperty(_audioUnitPlayer.audioUnit, kAudioUnitProperty_ScheduleStartTimeStamp,
//                                     kAudioUnitScope_Global, 0, &startTime, sizeof(startTime)),
//                "AudioUnitSetProperty(kAudioUnitProperty_ScheduleStartTimeStamp)");
//}
//
//- (void)playthroughSwitchChanged:(ITSwitch*)sender
//{
//    if(sender.isOn)
//    {
//        self.playthrough = [[AEPlaythroughChannel alloc] initWithAudioController:_audioController];
//        [_audioController addInputReceiver:_playthrough];
//        [_audioController addChannels:@[ _playthrough ]];
//    }
//    else
//    {
//        [_audioController removeChannels:@[ _playthrough ]];
//        [_audioController removeInputReceiver:_playthrough];
//        self.playthrough = nil;
//    }
//}
//
//- (void)measurementModeSwitchChanged:(ITSwitch*)sender
//{
//    //    _audioController.useMeasurementMode = sender.on;
//}
//
//- (void)inputGainSliderChanged:(NSSlider*)slider
//{
//    //    _audioController.inputGain = slider.value;
//}
//
//- (void)limiterSwitchChanged:(ITSwitch*)sender
//{
//    //    if ( sender.isOn ) {
//    //        self.limiter = [[AELimiterFilter alloc] initWithAudioController:_audioController];
//    //        _limiter.level = 0.1;
//    //        [_audioController addFilter:_limiter];
//    //    } else {
//    //        [_audioController removeFilter:_limiter];
//    //        self.limiter = nil;
//    //    }
//}
//
//- (void)expanderSwitchChanged:(ITSwitch*)sender
//{
//    //    if ( sender.isOn ) {
//    //        self.expander = [[AEExpanderFilter alloc] initWithAudioController:_audioController];
//    //        [_audioController addFilter:_expander];
//    //    } else {
//    //        [_audioController removeFilter:_expander];
//    //        self.expander = nil;
//    //    }
//}
//
//- (void)reverbSwitchChanged:(ITSwitch*)sender
//{
//    //    if ( sender.isOn ) {
//    //        self.reverb = [[AEAudioUnitFilter alloc]
//    //        initWithComponentDescription:AEAudioComponentDescriptionMake(kAudioUnitManufacturer_Apple,
//    //        kAudioUnitType_Effect, kAudioUnitSubType_Reverb2) audioController:_audioController error:NULL];
//    //
//    //        AudioUnitSetParameter(_reverb.audioUnit, kReverb2Param_DryWetMix, kAudioUnitScope_Global, 0, 100.f, 0);
//    //
//    //        [_audioController addFilter:_reverb];
//    //    } else {
//    //        [_audioController removeFilter:_reverb];
//    //        self.reverb = nil;
//    //    }
//}
//
//- (void)channelButtonPressed:(VFButton*)sender
//{
//    BOOL selected = [_audioController.inputChannelSelection containsObject:@(sender.tag)];
//    selected = !selected;
//    if(selected)
//    {
//        _audioController.inputChannelSelection =
//            [[_audioController.inputChannelSelection arrayByAddingObject:@(sender.tag)]
//                sortedArrayUsingSelector:@selector(compare:)];
//        [self performSelector:@selector(highlightButtonDelayed:) withObject:sender afterDelay:0.01];
//    }
//    else
//    {
//        NSMutableArray* channels = [_audioController.inputChannelSelection mutableCopy];
//        [channels removeObject:@(sender.tag)];
//        _audioController.inputChannelSelection = channels;
//        sender.highlighted = NO;
//    }
//}
//
//- (void)highlightButtonDelayed:(VFButton*)button
//{
//    button.highlighted = YES;
//}
//
//- (void)record:(id)sender
//{
//    //    if ( _recorder ) {
//    //        [_recorder finishRecording];
//    //        [_audioController removeOutputReceiver:_recorder];
//    //        [_audioController removeInputReceiver:_recorder];
//    //        self.recorder = nil;
//    //        _recordButton.selected = NO;
//    //    } else {
//    //        self.recorder = [[AERecorder alloc] initWithAudioController:_audioController];
//    //        NSArray *documentsFolders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,
//    //        YES);
//    //        NSString *path = [documentsFolders[0] stringByAppendingPathComponent:@"Recording.aiff"];
//    //        NSError *error = nil;
//    //        if ( ![_recorder beginRecordingToFileAtPath:path fileType:kAudioFileAIFFType error:&error] ) {
//    //            [[[UIAlertView alloc] initWithTitle:@"Error"
//    //                                        message:[NSString stringWithFormat:@"Couldn't start recording: %@", [error
//    //                                        localizedDescription]]
//    //                                       delegate:nil
//    //                              cancelButtonTitle:nil
//    //                              otherButtonTitles:@"OK", nil] show];
//    //            self.recorder = nil;
//    //            return;
//    //        }
//    //
//    //        _recordButton.selected = YES;
//    //
//    //        [_audioController addOutputReceiver:_recorder];
//    //        [_audioController addInputReceiver:_recorder];
//    //    }
//}
//
//- (void)play:(id)sender
//{
//    if(_player)
//    {
//        [_audioController removeChannels:@[ _player ]];
//        self.player = nil;
//        //            _playButton.selected = NO;
//    }
//    else
//    {
//        NSArray* documentsFolders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString* path = [documentsFolders[0] stringByAppendingPathComponent:@"Recording.aiff"];
//
//        if(![[NSFileManager defaultManager] fileExistsAtPath:path])
//            return;
//
//        NSError* error = nil;
//        self.player = [AEAudioFilePlayer audioFilePlayerWithURL:[NSURL fileURLWithPath:path]
//                                                audioController:_audioController
//                                                          error:&error];
//
//        //            if ( !_player ) {
//        //                [[[UIAlertView alloc] initWithTitle:@"Error"
//        //                                            message:[NSString stringWithFormat:@"Couldn't start playback: %@",
//        //                                            [error
//        //                                            localizedDescription]]
//        //                                           delegate:nil
//        //                                  cancelButtonTitle:nil
//        //                                  otherButtonTitles:@"OK", nil] show];
//        //                return;
//        //            }
//        //
//        //            _player.removeUponFinish = YES;
//        //            __weak ViewController *weakSelf = self;
//        _player.completionBlock = ^{
//          //                ViewController *strongSelf = weakSelf;
//          //                strongSelf->_playButton.selected = NO;
//          //                weakSelf.player = nil;
//        };
//        [_audioController addChannels:@[ _player ]];
//
//        //            _playButton.selected = YES;
//    }
//}
//
//static inline float translate(float val, float min, float max)
//{
//    if(val < min)
//        val = min;
//    if(val > max)
//        val = max;
//    return (val - min) / (max - min);
//}
//
//- (void)updateLevels:(NSTimer*)timer
//{
//    //    [CATransaction begin];
//    //    [CATransaction setDisableActions:YES];
//    //
//    //    Float32 inputAvg, inputPeak, outputAvg, outputPeak;
//    //    [_audioController inputAveragePowerLevel:&inputAvg peakHoldLevel:&inputPeak];
//    //    [_audioController outputAveragePowerLevel:&outputAvg peakHoldLevel:&outputPeak];
//    //    NSView *headerView = self.tableView.tableHeaderView;
//    //
//    //    _inputLevelLayer.frame = CGRectMake(headerView.bounds.size.width/2.0 - 5.0 - (translate(inputAvg, -20, 0) *
//    //    (headerView.bounds.size.width/2.0 - 15.0)),
//    //                                        90,
//    //                                        translate(inputAvg, -20, 0) * (headerView.bounds.size.width/2.0 - 15.0),
//    //                                        10);
//    //
//    //    _outputLevelLayer.frame = CGRectMake(headerView.bounds.size.width/2.0,
//    //                                         _outputLevelLayer.frame.origin.y,
//    //                                         translate(outputAvg, -20, 0) * (headerView.bounds.size.width/2.0 - 15.0),
//    //                                         10);
//    //
//    //    [CATransaction commit];
//}
//
////-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void
////*)context {
////    if ( context == &kInputChannelsChangedContext ) {
////        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
////    }
////}
//
//@end
