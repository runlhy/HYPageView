//
//  WaterFlowLayout.m
//  UICollectionDemo_01
//
//  Created by runlhy on 16/6/16.
//  Copyright © 2016年 runlhy. All rights reserved.
//

#import "WaterFlowLayout.h"

static const CGFloat defaultColumnMargin = 3;
static const CGFloat defaultRowMargin = 3;
static const UIEdgeInsets defaultEdgeInsets = {3, 3, 3, 3};
static const NSInteger defaultColumnCount = 3;
static const NSInteger defaultHeight = 100;

@interface WaterFlowLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

/** collection滚动高度 */
@property (nonatomic, assign) CGFloat maxHeight;

/** 当前高度 */
@property (nonatomic, assign) CGFloat sectionHeight;

/** 当前最大y */
@property (nonatomic, assign) CGFloat maxSectionHeight;

@end

@implementation WaterFlowLayout

#pragma mark - lazy
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray){
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 *  初始化
 */
- (void)prepareLayout{
    [super prepareLayout];
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    self.attrsArray = nil;
    
    //创建cell对应的布局属性
    for (int j=0; j<[self.collectionView numberOfSections]; j++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:j];
        for (NSInteger i = 0; i < count; i++) {
            //创建位置
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:j];
            //获取indexPath对应的布局属性
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexpath];
            
            [self.attrsArray addObject:attrs];
        }
    }
}
/**
 *  决定cell的排布
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //NSLog(@"%s",__func__);
    return self.attrsArray;
}
/**
 *  返回indexpath对应cell的 布局的属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    CGFloat w = (collectionViewW - defaultEdgeInsets.left - defaultEdgeInsets.right - (defaultColumnCount - 1)*defaultColumnMargin)/defaultColumnCount;
    CGFloat h = w / ((sqrt(5.0)-1)/2.0);
    CGFloat x = defaultEdgeInsets.left;
    CGFloat y = defaultEdgeInsets.top;
    
    //12个为一个周期 根据周期计算位置
    NSInteger section = indexPath.row / 6;
    NSInteger row = indexPath.row % 6;
    switch (row) {
        case 0:
        case 1:
        case 2:{
            y = section * (3 * (h + defaultRowMargin)) + defaultEdgeInsets.top;
            x = defaultEdgeInsets.left + row * (w + defaultColumnMargin);
        }
            break;
        case 3:{
            if (section % 2 == 0){
                y = (3 * section + 1) * (h + defaultRowMargin) + defaultEdgeInsets.top;
            }else{
                y = (3 * section + 1) * (h + defaultRowMargin) + defaultEdgeInsets.top;
                w = w * 2 + defaultColumnMargin;
                h = h * 2 + defaultRowMargin;
            }
        }
            break;
        case 4:{
            if (section % 2 == 0){
                y = (3 * section + 2) * (h + defaultRowMargin) + defaultEdgeInsets.top;
            }else{
                x = defaultEdgeInsets.left + 2 * (w + defaultColumnMargin);
                y = (3 * section + 1) * (h + defaultRowMargin) + defaultEdgeInsets.top;
            }
        }
            break;
        default:{
            if (section % 2 == 0){
                x = defaultEdgeInsets.left + w + defaultColumnMargin;
                y = (3 * section + 1) * (h + defaultRowMargin) + defaultEdgeInsets.top;
                w = w * 2 + defaultColumnMargin;
                h = h * 2 + defaultRowMargin;
            }else{
                x = defaultEdgeInsets.left + 2 * (w + defaultColumnMargin);
                y = (3 * section + 2) * (h + defaultRowMargin) + defaultEdgeInsets.top;
            }
        }
            break;
    }
    
    //设置布局属性的frame
    y += _sectionHeight;
    attributes.frame = CGRectMake(x, y, w, h);
    
    //解决最后一块小于前一块的问题
    if (_maxSectionHeight < y + h) {
        _maxSectionHeight = y + h;
    }
    //下一组时 更新高度
    if (indexPath.row == [self.collectionView numberOfItemsInSection:indexPath.section]-1) {
        _sectionHeight = _maxSectionHeight + defaultEdgeInsets.bottom;
    }
    //获得最底部位置
    _maxHeight = _maxSectionHeight + defaultEdgeInsets.bottom;
    return attributes;
}

/**
 *  滚动范围
 */
- (CGSize)collectionViewContentSize{
    return CGSizeMake(0,_maxHeight);
}

@end
