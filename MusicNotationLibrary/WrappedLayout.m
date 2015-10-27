//
//  WrappedLayout.m
//  MusicApp
//
//  Created by Scott on 8/5/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "WrappedLayout.h"

#import "TestViewController.h"

#define SLIDE_WIDTH \
    700.0   // width  of the SlideCarrier image (which includes shadow margins) in points, and thus the width  that we
            // give to a Slide's root view
#define SLIDE_HEIGHT \
    150.0   // height of the SlideCarrier image (which includes shadow margins) in points, and thus the height that we
            // give to a Slide's root view

#define SLIDE_SHADOW_MARGIN \
    10.0   // margin on each side between the actual slide shape edge and the edge of the SlideCarrier image
#define SLIDE_CORNER_RADIUS 8.0   // corner radius of the slide shape in points
#define SLIDE_BORDER_WIDTH 4.0    // thickness of border when shown, in points

#define X_PADDING 10.0
#define Y_PADDING 10.0

@implementation WrappedLayout

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setItemSize:NSMakeSize(SLIDE_WIDTH, SLIDE_HEIGHT)];
        [self setMinimumInteritemSpacing:X_PADDING];
        [self setMinimumLineSpacing:Y_PADDING];
        [self setSectionInset:NSEdgeInsetsMake(Y_PADDING, X_PADDING, Y_PADDING, X_PADDING)];
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(NSRect)newBounds
{
    return YES;
}

- (NSCollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSCollectionViewLayoutAttributes* attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
//    [attributes setZIndex:[indexPath item]];
    //    attributes.frame = [self.testViewController frameAtIndex:indexPath.item];
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(NSRect)rect
{
    NSArray* layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
    for(NSCollectionViewLayoutAttributes* attributes in layoutAttributesArray)
    {
//        [attributes setZIndex:[[attributes indexPath] item]];
        //        attributes.frame = [self.testViewController frameAtIndex:attributes.indexPath.item];
        //
    }
    return layoutAttributesArray;
}


@end
