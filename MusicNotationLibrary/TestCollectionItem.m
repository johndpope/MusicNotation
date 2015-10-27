//
//  TestCollectionItem.m
//  MusicApp
//
//  Created by Scott on 8/5/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "TestCollectionItem.h"
#import "TestAction.h"
#import "RenderLayer.h"
#import "vfMacros.h"
#import "TestCollectionItemView.h"

#define RENDERLAYER_CORNER_RADIUS 8.0

NSString* const kTestCollectionItemid = @"testCollectionItemid";

@interface TestCollectionItem ()

@property (strong, nonatomic) TestAction* test;
@property (strong, nonatomic) RenderLayer* renderLayer;
//@property (strong, nonatomic) NSTextField* textField; // already a convenience property with this name
@property (strong, nonatomic) NSTextField* textLabel;

@end

@implementation TestCollectionItem

- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    if(self)
    {
    }
    return self;
}

- (void)dealloc
{
    for(NSView* subView in self.view.subviews)
    {
        [subView removeFromSuperview];
    }
    for(CALayer* layer in self.view.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
}

#pragma mark - properties

- (RenderLayer*)renderLayer
{
    if(!_renderLayer)
    {
        _renderLayer = [[RenderLayer alloc] init];
        _renderLayer.delegate = _renderLayer;
        _renderLayer.drawsAsynchronously = YES;
        _renderLayer.frame = self.view.frame;
        _renderLayer.parentView = (TestCollectionItemView*)self.view;
        _renderLayer.backgroundColor = SHEET_MUSIC_COLOR.CGColor;
        _renderLayer.cornerRadius = RENDERLAYER_CORNER_RADIUS;
    }
    return _renderLayer;
}

- (NSTextField*)textLabel
{
    if(!_textLabel)
    {
        _textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        _textLabel.editable = NO;
        _textLabel.selectable = YES;
        //    textField.backgroundColor = [NSColor clearColor];
        _textLabel.drawsBackground = NO;
        _textLabel.stringValue = self.test.name ?: @"";
        [_textLabel sizeToFit];
    }
    return _textLabel;
}

#pragma mark - NSViewController lifecycle

- (void)loadView
{
    self.view = [[TestCollectionItemView alloc] init];
    [self.view addSubview:self.textLabel];
}

- (void)viewWillAppear
{
    //    [self.renderLayer clearLayer];
    [super viewWillAppear];
}

- (void)viewDidAppear
{
    [super viewDidAppear];
}

- (void)viewWillDisappear
{
    [super viewWillDisappear];
}

- (void)viewDidDisappear
{
    [super viewDidDisappear];
    //    [self.renderLayer clearLayer];
    //    [self prepareForReuse];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setLayer:self.renderLayer];
    [self.view setWantsLayer:YES];
    //    [self.collectionView invalidateLayoutOfLayer:self.collectionView.layer];
}

#pragma mark - <NSCollectionViewElement>

- (void)prepareForReuse
{
    [self.renderLayer clearLayer];
        for(NSView* subView in self.view.subviews)
        {
            [subView removeFromSuperview];
        }
    
    //    [self.view addSubview:self.textLabel];
    //    self.textLabel.stringValue = @"Arst";
    //    [self.textLabel sizeToFit];
    
        for(CALayer* layer in self.view.layer.sublayers)
        {
            [layer removeFromSuperlayer];
        }
}

- (void)applyLayoutAttributes:(NSCollectionViewLayoutAttributes*)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    self.view.frame = layoutAttributes.frame;
}

- (void)setRepresentedObject:(id)newRepresentedObject
{
    [super setRepresentedObject:newRepresentedObject];

    if([newRepresentedObject isKindOfClass:[TestAction class]])
    {
        if(self.renderLayer.testAction != newRepresentedObject)
        {
            self.textLabel.stringValue = ((TestAction*)newRepresentedObject).name;
            [self.textLabel sizeToFit];
            self.renderLayer.testAction = newRepresentedObject;
        }
    }
}

@end
