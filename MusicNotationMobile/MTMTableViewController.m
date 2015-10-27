//
//  MTMTableViewController.m
//  MusicApp
//
//  Created by Scott on 8/1/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "MTMTableViewController.h"
#import "MTMTestViewController.h"
#import <ReflectableEnum/ReflectableEnum.h>
#import "TestType.h"
#import "Tests.h"

@interface MTMTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray* tests;
@end

@implementation MTMTableViewController

- (instancetype)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    if(self)
    {
    }
    return self;
}

- (NSArray*)tests
{
    if(!_tests)
    {
        _tests = [NSMutableArray array];
        NSArray* allNumValues = REFAllValuesInTestType();
        for(NSNumber* numType in allNumValues)
        {
            NSString* typeString = REFStringForMemberInTestType([numType integerValue]);
            [_tests addObject:typeString];
        }
    }
    return _tests;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tests.count;
}

- (nonnull UITableViewCell*)tableView:(nonnull UITableView*)tableView
                cellForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.accessoryView = nil;
    cell.textLabel.text = self.tests[indexPath.row];

    //    switch(indexPath.section)
    //    {
    //        case 0:
    //        {
    //            switch(indexPath.row)
    //            {
    //                case 0:
    //                {
    //                }
    //                break;
    //            }
    //        }
    //        break;
    //    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"testSegue"])
    {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger row = indexPath.row;
        //        NSDate* object = self.objects[indexPath.row];

        //        LessonTabController* tabController = (LessonTabController*)[segue destinationViewController];
        //        LessonDetailViewController* controller = (LessonDetailViewController*)[tabController.viewControllers
        //        firstObject];
        // UINavigationController* navController = (UINavigationController*)[tabController.viewControllers firstObject];
        //        LessonDetailViewController* controller = (LessonDetailViewController*)[navController
        //        topViewController];
        //        [controller setDetailItem:object];
        //        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        //        controller.navigationItem.leftItemsSupplementBackButton = YES;

//        MTMTestViewController* testController = [[MTMTestViewController alloc]initWithTestType:indexPath.row];
        
        MTMTestViewController* testController = (MTMTestViewController*)[segue destinationViewController];
        testController.testType = row;
    
    
        
    }
}

@end
