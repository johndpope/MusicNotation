//
//  VFTestViewController.m
//  MusicApp
//
//  Created by Scott on 8/3/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "TestViewController.h"
#if TARGET_OS_IPHONE
#elif TARGET_OS_MAC
//#import "TestCollectionItemView.h"
#import "TestCollectionItem.h"
#endif
#import "TestAction.h"
#import "RenderLayer.h"

@interface TestViewController ()
@property (assign, nonatomic) NSInteger numberOfSections;
@property (assign, nonatomic) NSInteger numberOfItems;
#if TARGET_OS_IPHONE
@property (strong, nonatomic) NSMutableDictionary* rowHeights;
#elif TARGET_OS_MAC
#endif
@property (strong, nonatomic) NSMutableArray* tests;            // collection of VFTestView
@property (strong, nonatomic) NSMutableDictionary* testItems;   // collection of TestCollectionItem
@end

@implementation TestViewController

- (void)start
{
    self.numberOfSections = 1;
    self.numberOfItems = 0;
    self.tests = [NSMutableArray array];
    self.testItems = [NSMutableDictionary dictionary];
}

#if TARGET_OS_IPHONE
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(nonnull UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return self.numberOfItems;
    }
    return 0;
}

- (CGFloat)tableView:(nonnull UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    if(indexPath.section == 0)
    {
        return ((TestCollectionItemView*)self.tests[indexPath.row]).frame.size.height;
    }
    return 0;
}

- (nonnull UITableViewCell*)tableView:(nonnull UITableView*)tableView
                cellForRowAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    static NSString* cellIdentifier = @"cellId";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = @"arst";

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    TestCollectionItemView* test = self.tests[indexPath.row];
    //    cell.frame = test.frame;
    [cell.contentView addSubview:test];
    [test setNeedsDisplay];

    return cell;
}

#pragma mark - <UITableViewDelegate>

//--------------------------------
#elif TARGET_OS_MAC
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        //        self.tableView.delegate = self;
        //        self.tableView.dataSource = self;
        self.numberOfSections = 1;
        self.numberOfItems = 0;
        self.tests = [NSMutableArray array];
        self.testItems = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - <NSCollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(NSCollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tests.count;
}

- (nonnull NSCollectionViewItem*)collectionView:(nonnull NSCollectionView*)collectionView
            itemForRepresentedObjectAtIndexPath:(nonnull NSIndexPath*)indexPath
{
    if([self.testItems objectForKey:indexPath])
    {
        return [self.testItems objectForKey:indexPath];
    }

    TestCollectionItem* testCollectionItem =
        [collectionView makeItemWithIdentifier:kTestCollectionItemid forIndexPath:indexPath];
    TestAction* testAction = self.tests[indexPath.item];
    [testCollectionItem setRepresentedObject:testAction];

    return testCollectionItem;
}

#pragma mark - <NSCollectionViewDelegate>

#pragma mark - <NSCollectionViewDelegateFlowLayout>

- (NSSize)collectionView:(NSCollectionView*)collectionView
                  layout:(NSCollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    TestAction* testAction = self.tests[indexPath.item];
    return testAction.frame.size;
}

/*
 - (NSEdgeInsets)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout
 insetForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout
 minimumLineSpacingForSectionAtIndex:(NSInteger)section;
 - (CGFloat)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout
 minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
 - (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout
 referenceSizeForHeaderInSection:(NSInteger)section;
 - (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout*)collectionViewLayout
 referenceSizeForFooterInSection:(NSInteger)section;
 */

#endif

#pragma mark - runTest

- (void)runTest:(NSString*)name func:(SEL)selector
{
    NSMethodSignature* signature = [self methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:self];
    //    [invocation setArgument:&name atIndex:2];
    //    [invocation setArgument:&ctx atIndex:3];
    [invocation invoke];

    //    BOOL* success __unsafe_unretained;   // http://stackoverflow.com/a/22034059/629014
    //    [invocation getReturnValue:&success];
}

- (void)runTest:(NSString*)name func:(SEL)selector frame:(CGRect)frame;
{
    self.numberOfItems++;
    TestAction* testAction = [TestAction testWithName:name andSelector:selector andTarget:self andFrame:frame];
    [self.tests addObject:testAction];
}

- (void)runTest:(NSString*)name func:(SEL)selector params:(NSObject*)params;
{
    NSMethodSignature* signature = [self methodSignatureForSelector:selector];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setSelector:selector];
    [invocation setTarget:self];
    [invocation setArgument:&name atIndex:2];
    [invocation setArgument:&params atIndex:3];
    [invocation invoke];
}

- (void)runTest:(NSString*)name func:(SEL)selector frame:(CGRect)frame params:(NSObject*)params;
{
    TestAction* testAction = [TestAction testWithName:name andSelector:selector andTarget:self andFrame:frame];
    testAction.params = params;
    [self.tests addObject:testAction];
    //    [self.testItems setObject:testAction forKey:[NSIndexPath indexPathForItem:self.numberOfItems inSection:0]];
    self.numberOfItems++;
}

- (RenderLayer*)renderLayer
{
    CALayer* mainLayer = self.view.layer;
    if([mainLayer isKindOfClass:[RenderLayer class]])
    {
        return mainLayer;
    }
    else
        return nil;
}

@end
