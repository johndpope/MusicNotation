//
//  AppDelegate.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "AppDelegate.h"
//#import "DDLog.h"
//#import "DDASLLogger.h"
//#import "DDTTYLogger.h"
//#import "DDFileLogger.h"

// static const int ddLogLevel = LOG_LEVEL_ALL;

#import <CocoaLumberjack/CocoaLumberjack.h>

#import "BrowserWindowController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)aNotification
{
    // Insert code here to initialize your application

    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    DDLogInfo(@"Application finished launching");
    
    BrowserWindowController* browserController = [[BrowserWindowController alloc]init];
    if (browserWindowControllers == nil) {
        browserWindowControllers = [[NSMutableSet alloc] init];
    }
    [browserWindowControllers addObject:browserController];
    if (browserController) {
        [browserController showWindow:self];
    }
    
    NSWindow *browserWindow = [browserController window];
    if (browserWindow) {
        
    }
}

- (void)applicationWillTerminate:(NSNotification*)aNotification
{
    // Insert code here to tear down your application

}

@end
