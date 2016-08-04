//
//  CircleLayout.m
//  MyDaily
//
//  Created by Jiaxiang Li on 8/4/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "CircleLayout.h"

static const CGFloat cell_size = 90;

@implementation CircleLayout

//Override method
//Initialize properties
-(void) prepareLayout {
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    _center = CGPointMake(size.width / 2, size.height / 2 - 60);
    _cellcount = [self.collectionView numberOfItemsInSection:0];
    _radius = MIN(size.width, size.height) / 3.5;
}


//Override method
//Returns the width and height of collection view's content
-(CGSize) collectionViewContentSize {
    return CGSizeMake(kScreenWidth, kScreenHeight);
}


//Override method
//Returns all of element's layout attributes in the specific rect which is passed as parameter
-(NSArray *) layoutAttributesForElementsInRect:(CGRect) rect {
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (int i = 0; i < _cellcount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
    }
    
    return attributes;
}


//Override method
//Return cell layout attributes for specific index path which is passed as parameter
-(UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *cellAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    cellAttribute.size = CGSizeMake(cell_size, cell_size);
    
    if (indexPath.item == 0) {
        //set attribut for the cell in center
        cellAttribute.center = CGPointMake(_center.x, _center.y);
    }else {
        // 2 * indexPath.item * M_PI = radian
        // _center.x + _radius * radian = x-axis for cellAttribute.center.x
        // _center.y + _radius *radian = y-axis for cellAttribute.cent.y
        cellAttribute.center = CGPointMake(_center.x + _radius * cosf(2 * indexPath.item * M_PI / (_cellcount- 1)), _center.y + _radius * sinf(2 * indexPath.item * M_PI / (_cellcount - 1)));
    }

    
    return cellAttribute;
}

//Override method
//Return bool value to indicate whether refresh the layout when bound is changed
-(BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(oldBounds) != CGRectGetWidth(newBounds)) {
        return YES;
    }
    
    return NO;
}

@end
