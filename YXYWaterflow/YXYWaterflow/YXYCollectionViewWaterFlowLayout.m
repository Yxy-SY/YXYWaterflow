//
//  YXYCollectionViewWaterFlowLayout.m
//  YXYWaterflow
//
//  Created by yuxiuyi on 2018/5/15.
//  Copyright © 2018年 yuxiuyi. All rights reserved.
//

#import "YXYCollectionViewWaterFlowLayout.h"

/** 默认的列数 */
static const NSInteger XMGDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat XMGDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat XMGDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets XMGDefaultEdgeInsets = {10, 10, 10, 10};

@interface YXYCollectionViewWaterFlowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
@end

@implementation YXYCollectionViewWaterFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i = 0; i < XMGDefaultColumnCount; i++)
        [self.columnHeights addObject:@(XMGDefaultEdgeInsets.top)];

    NSUInteger count = [self.collectionView  numberOfItemsInSection:0];
    
    for (NSUInteger i=0; i<count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attrs = [self  layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

-(NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

-(NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    CGFloat w = (collectionViewW - XMGDefaultEdgeInsets.left - XMGDefaultEdgeInsets.right - (XMGDefaultColumnCount - 1)*XMGDefaultColumnMargin)/XMGDefaultColumnCount;
    
    CGFloat h = 50 + arc4random_uniform(100);
    
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < XMGDefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = XMGDefaultEdgeInsets.left + destColumn * (w + XMGDefaultColumnMargin);
    CGFloat y = minColumnHeight;
    if (y != XMGDefaultEdgeInsets.top) {
        y += XMGDefaultRowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}


-(CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < XMGDefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(320, maxColumnHeight + XMGDefaultEdgeInsets.bottom);
}
@end
